/*****************************************************************
 M3URLConnectionOperation.h
 M3AppKit
 
 Created by Martin Pilkington on 01/07/2010.
 
 Please read the LICENCE.txt for licensing information
*****************************************************************/


/***************************
 An operation that encapsulates a URL connection
 Behind the scenes this uses NS
 @since M3Foundation 1.0 or later
 **************************/
@interface M3URLConnectionOperation : NSOperation

/***************************
 Initialise a new operation with the supplied request
 @param aRequest The request for the connection operation
 @return A newly initialised M3URLConnectionOperation
 @since M3Foundation 1.0 or later
 **************************/
- (id)initWithURLRequest:(NSURLRequest *)aRequest;

/***************************
 The block to call when the connection has completed
 This block is called on the main thread. The operation doesn't complete until after it has executed
 @since M3Foundation 1.0 or later
 **************************/
@property (copy) void (^downloadCompletionBlock)(NSInteger aResponse, NSData *aData, NSError *aError);

/***************************
 The request for the operation
 @since M3Foundation 1.0 or later
 **************************/
@property (readonly) NSURLRequest *request;

/***************************
 Whether the operation should automatically try a second time after a time out.
 @since M3Foundation 1.0 or later
 **************************/
@property (assign) BOOL shouldAutomaticallyRetryAfterTimeOut;

@end
