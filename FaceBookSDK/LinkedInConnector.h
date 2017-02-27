//
//  LinkedInConnector.h
//  LinkedInSampleApp
//
//  Created by 10times on 05/12/16.
//  Copyright © 2016 10times. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LinkedInConnectorDelegate<NSObject>
@optional

-(void)UserDataReceived:(NSDictionary *)data;
-(void)LinkedInIdReceived:(NSString *)LinkedInID;
-(void)NameReceived_firstName:(NSString *)firstName lastName:(NSString *)lastName;
-(void)HeadLineReceived:(NSString *)headline;
-(void)IndustryReceived:(NSString *)industry;
-(void)threeCurrentPositions:(NSArray *)threeCurrentPosition;
-(void)PictureURLReceived:(NSString *)pictureURLString;

@end
@interface LinkedInConnector : NSObject

-(id)initWithAccessToken:(NSString *)linkedInAccessToken;

@property (nonatomic,strong ) NSString *access_token;
@property (nonatomic,strong ) id<LinkedInConnectorDelegate> delegate;

@property (nonatomic) BOOL isDataLoaded;
@property (nonatomic,strong) NSString *linkedinFirstName;
@property (nonatomic,strong) NSString *linkedinLastName;
@property (nonatomic,strong) NSString *linkedinHeadline;
@property (nonatomic,strong) NSString *linkedinID;
@property (nonatomic,strong) NSString *linkedinIndustry;
@property (nonatomic,strong) NSArray  *linkedinCurrentThreePositions;
@property (nonatomic,strong) NSString *linkedinPictureURL;


-(void)getUserData;
-(void)getPicture;
-(void)getID;
-(void)getName;
-(void)getHeadLine;
-(void)getThreeCurrentPositions;
-(void)getIndustry;

@end
