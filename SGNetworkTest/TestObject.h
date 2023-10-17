//
//  TestObject.h
//  SGNetworkTest
//
//  Created by Blankwonder on 1/5/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TestObject;
@protocol TestObjectOutput <NSObject>

- (void)testObject:(TestObject *)obj hasNewOutput:(NSString *)line;

@end

@interface TestObject : NSObject

- (void)start;

@property (nonatomic, weak) id <TestObjectOutput> output;
@property (nonatomic) int totalRound;
@property (nonatomic) NSArray *testURLs;

@end

@interface HTTPDelayTestObject : TestObject
@end

@interface HTTPConnectivyTestObject : TestObject
@end



NS_ASSUME_NONNULL_END
