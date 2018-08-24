//
//  GSKeyChainDataManager.m
//  keychaintest
//
//  Created by Apple on 16/8/2.
//  Copyright © 2016年 张国森. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GSKeyChainDataManager.h"

static NSString * const KEY_IN_KEYCHAIN_UUID = @"唯一识别的KEY_UUID000";
static NSString * const KEY_UUID = @"唯一识别的key_uuid000";


@interface GSKeyChain : NSObject

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service;

+ (void)save:(NSString *)service data:(id)data;

+ (id)load:(NSString *)service;

+ (void)delete:(NSString *)service;
@end



@implementation GSKeyChain
+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)save:(NSString *)service data:(id)data {
    //Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    //Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    //Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

+ (id)load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

+ (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

@end




@implementation GSKeyChainDataManager



+(void)saveUUID:(NSString *)UUID{
    
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:UUID forKey:KEY_UUID];
    
    [GSKeyChain save:KEY_IN_KEYCHAIN_UUID data:usernamepasswordKVPairs];
}

+(NSString *)readUUID{
    
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[GSKeyChain load:KEY_IN_KEYCHAIN_UUID];
    
    NSString *deviceUUID = [usernamepasswordKVPair objectForKey:KEY_UUID];
    
    
    if (deviceUUID.length == 0) {
        deviceUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [GSKeyChainDataManager saveUUID:deviceUUID];
    }
    return deviceUUID;
}

+(void)deleteUUID{
    
    [GSKeyChain delete:KEY_IN_KEYCHAIN_UUID];
    
}

@end
