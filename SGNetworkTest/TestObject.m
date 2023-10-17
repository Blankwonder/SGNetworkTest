//
//  TestObject.m
//  SGNetworkTest
//
//  Created by Blankwonder on 1/5/22.
//

#import "TestObject.h"

@implementation TestObject {
    @protected
    int _currentRound;
}

- (void)jobStart {
}

- (void)jobEnd {
    [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"Round #%d completed", _currentRound - 1]];
    [self.output testObject:self hasNewOutput:@"\n"];
    [self performSelector:@selector(start) withObject:nil afterDelay:0.5];
}

- (void)allCompleted {
    
}

- (void)start {
    if (_currentRound < self.totalRound + 1) {
        _currentRound++;
        [self jobStart];
    } else {
        [self allCompleted];
    }
}

@end

@interface HTTPDelayTestObject () <NSURLSessionDelegate>

@end

@implementation HTTPDelayTestObject {
    NSURLSession *_session;
    
    NSMutableArray *_results, *_roundResults;
}

- (instancetype)init {
    self = [super init];
    
    _roundResults = [NSMutableArray array];
    self.totalRound = 10;
    
    return self;
}

- (void)jobStart {
    _session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration delegate:self delegateQueue:NSOperationQueue.mainQueue];
    
    _results = [NSMutableArray array];
    
    if (_currentRound == 1) {
        [self.output testObject:self hasNewOutput:@"Warming up round, the result won't count."];
    }

    for (NSString *url in self.testURLs) {
        [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"Start testing: %@", url]];
        
        CFAbsoluteTime t = CFAbsoluteTimeGetCurrent();
        
        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        req.HTTPMethod = @"HEAD";
        req.timeoutInterval = 5;
        
        [[_session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error && ((NSHTTPURLResponse *)response).statusCode >= 400) {
                error = [NSError errorWithDomain:@"SGNetworkTest" code:1 userInfo:@{NSLocalizedDescriptionKey:[NSString stringWithFormat:@"Invalid status code: %d", ((NSHTTPURLResponse *)response).statusCode]}];
            }
            
            if (error || !response) {
                [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"Test failed: %@ %@", url, error]];
                [_results addObject:@(-1)];

                return;
            }
            
            double res = (CFAbsoluteTimeGetCurrent() - t) * 1000.0;
            [_results addObject:@(res)];
            
            [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"Test completed in %.0fms: %@", res, url]];
            
            if (_results.count == self.testURLs.count) {
                int sum = 0;

                for (NSNumber *n in _results) {
                    sum += n.intValue;
                    if (n.intValue == -1) {
                        [self jobEnd];
                        return;
                    }
                }
                
                double avg = sum / (double)_results.count;
                [_roundResults addObject:@(avg)];
                [_session invalidateAndCancel];
                _session = nil;

                [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"All test completed, average: %.0fms", avg]];
                [self jobEnd];
            }
        }] resume];
    }
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest *))completionHandler {
    completionHandler(nil); // Disable 301/302 redirect
}

- (void)allCompleted {
    [_roundResults removeObjectAtIndex:0];

    NSInteger top = _roundResults.count / 2;

    [_roundResults sortUsingSelector:@selector(compare:)];
    [_roundResults removeObjectsInRange:NSMakeRange(top, _roundResults.count - top)];

    [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"All round completed, average of the top %ld rounds: %.0fms", _roundResults.count, [[_roundResults valueForKeyPath:@"@avg.self"] doubleValue]]];
}

@end


@interface HTTPConnectivyTestObject () <NSURLSessionDelegate>

@end


@implementation HTTPConnectivyTestObject  {
    NSURLSession *_session;

    NSMutableArray *_results, *_roundResults;
}

- (instancetype)init {
    self = [super init];

    _roundResults = [NSMutableArray array];
    self.totalRound = 0;

    return self;
}

- (void)jobStart {
    _session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.ephemeralSessionConfiguration delegate:self delegateQueue:NSOperationQueue.mainQueue];

    _results = [NSMutableArray array];

    for (NSString *url in self.testURLs) {
        [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"Start testing: %@", url]];

        CFAbsoluteTime t = CFAbsoluteTimeGetCurrent();

        NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
        req.HTTPMethod = @"HEAD";
        req.timeoutInterval = 5;

        [[_session dataTaskWithRequest:req completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

            if (error || !response) {
                [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"Test failed: %@ %@", url, error]];
                [_results addObject:@(-1)];

                return;
            }

            double res = (CFAbsoluteTimeGetCurrent() - t) * 1000.0;
            [_results addObject:@(res)];

            [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"Test completed in %.0fms: %@", res, url]];

            if (_results.count == self.testURLs.count) {
                int sum = 0;

                for (NSNumber *n in _results) {
                    sum += n.intValue;
                    if (n.intValue == -1) {
                        [self jobEnd];
                        return;
                    }
                }

                double avg = sum / (double)_results.count;
                [_roundResults addObject:@(avg)];
                [_session invalidateAndCancel];
                _session = nil;

                [self.output testObject:self hasNewOutput:[NSString stringWithFormat:@"All test completed, average: %.0fms", avg]];
                [self jobEnd];
            }
        }] resume];
    }
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest *))completionHandler {
    completionHandler(nil); // Disable 301/302 redirect
}

- (void)allCompleted {
}


@end
