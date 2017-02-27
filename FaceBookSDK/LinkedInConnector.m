//
//  LinkedInConnector.m
//  LinkedInSampleApp
//
//  Created by 10times on 05/12/16.
//  Copyright © 2016 10times. All rights reserved.
//

#import "LinkedInConnector.h"
#import "ViewController.h"
#import "DetailViewController.h"
#import "UserDetailViewController.h"

@implementation LinkedInConnector
{
    UserDetailViewController *userData;
}

@synthesize access_token,linkedinCurrentThreePositions,linkedinFirstName
,linkedinHeadline,linkedinID,linkedinIndustry,linkedinLastName,linkedinPictureURL,isDataLoaded;

-(id)initWithAccessToken:(NSString *)accessToken
{
    self = [super init];
    self.access_token = accessToken;
    isDataLoaded = FALSE;
    
    return self;
}

-(void)getUserData
{
        [self performSelectorInBackground:@selector(getDataInBackGround:) withObject:@"UserData"];
}

-(void)getID
{
    if (isDataLoaded)
        [self.delegate LinkedInIdReceived:linkedinID];
    else
        [self performSelectorInBackground:@selector(getDataInBackGround:) withObject:@"id"];
}

- (void)getPicture
{
    if (isDataLoaded)
        [self.delegate PictureURLReceived:linkedinPictureURL];
    else
        [self performSelectorInBackground:@selector(getDataInBackGround:) withObject:@"pictureUrl"];
}

-(void)getName
{
    if (isDataLoaded)
        [self.delegate NameReceived_firstName:linkedinFirstName lastName:linkedinLastName];
    else
        [self performSelectorInBackground:@selector(getDataInBackGround:) withObject:@"name"];
}

-(void)getHeadLine
{
    if (isDataLoaded)
        [self.delegate HeadLineReceived:linkedinHeadline];
    else
        [self performSelectorInBackground:@selector(getDataInBackGround:) withObject:@"headline"];
}

-(void)getIndustry
{
    if (isDataLoaded)
        [self.delegate IndustryReceived:linkedinIndustry];
    else
        [self performSelectorInBackground:@selector(getDataInBackGround:) withObject:@"industry"];
    
}

-(void)getThreeCurrentPositions
{
    if (isDataLoaded)
        [self.delegate threeCurrentPositions:linkedinCurrentThreePositions];
    else
        [self performSelectorInBackground:@selector(getDataInBackGround:) withObject:@"position"];
    
}

-(void)getDataInBackGround:(NSString *)valueCalled
{
    
    userData = [[UserDetailViewController alloc] init];
    
    NSData *dateFromServer = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://api.linkedin.com/v1/people/~:(id,firstName,lastName,email-address,headline,industry,positions,picture-url,phone-numbers,location,public-profile-url,summary,specialties,educations,date-of-birth,skills)?format=json&oauth2_access_token=%@",self.access_token]]];
    
    NSError *e = nil;
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:dateFromServer options: NSJSONReadingMutableContainers error: &e];
    
    NSLog(@"%@", jsonDictionary);
    
    NSString *linkedInfirstName = [jsonDictionary valueForKey:@"firstName"];
    NSString *linkedInlastName = [jsonDictionary valueForKey:@"lastName"];
    
    userData.eName = [[linkedInfirstName stringByAppendingString:@" "] stringByAppendingString:linkedInlastName];
    
    userData.eDesignation = [jsonDictionary valueForKey:@"headline"];
   userData.eCompany = [[[[jsonDictionary valueForKey:@"positions"] valueForKey:@"values"] valueForKey:@"company"] valueForKey:@"name"];
    
    NSLog(@"%@", userData.eCompany);
    
    userData.eLocation = [[jsonDictionary valueForKey:@"location"] valueForKey:@"name"];

    NSString *linkedinPicture = [jsonDictionary valueForKey:@"pictureUrl"];
    
    NSURL *imageURL = [NSURL URLWithString:linkedinPicture];
    userData.eImageData = [NSData dataWithContentsOfURL:imageURL];
    
    [[NSUserDefaults standardUserDefaults] setObject:userData.eName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:userData.eCompany forKey:@"userCompany"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:userData.eDesignation forKey:@"userDesignation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:userData.eLocation forKey:@"userLocation"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSUserDefaults standardUserDefaults] setObject:userData.eImageData forKey:@"userPicture"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    self.linkedinID = [[NSString alloc]initWithString:[jsonDictionary valueForKey:@"id"]];
    
    self.linkedinFirstName = [[NSString alloc]initWithString:[jsonDictionary valueForKey:@"firstName"]];
    
    if (![[jsonDictionary valueForKey:@"pictureUrl"] isEqualToString:@""]) {
        self.linkedinPictureURL = [jsonDictionary valueForKey:@"pictureUrl"];
        
    }
    
    self.linkedinLastName = [[NSString alloc]initWithString:[jsonDictionary valueForKey:@"lastName"]];

    self.linkedinHeadline = [[NSString alloc]initWithString:[jsonDictionary valueForKey:@"headline"]];

    self.linkedinCurrentThreePositions =[[NSArray alloc]initWithArray:[[jsonDictionary objectForKey:@"threeCurrentPositions"] valueForKey:@"values"]];
    
    self.isDataLoaded = TRUE;
    

    if ([valueCalled isEqualToString:@"UserData"])
    {
        [self.delegate UserDataReceived:jsonDictionary];
    }
    else
        if ([valueCalled isEqualToString:@"pictureUrl"])
            [self.delegate PictureURLReceived:linkedinPictureURL];
        else
            if ([valueCalled isEqualToString:@"id"])
                [self.delegate LinkedInIdReceived:linkedinID];
            else
                if ([valueCalled isEqualToString:@"name"])
                    [self.delegate NameReceived_firstName:linkedinFirstName lastName:linkedinLastName];
                else
                    if ([valueCalled isEqualToString:@"headline"])
                        [self.delegate HeadLineReceived:linkedinHeadline];
                    else
                        if ([valueCalled isEqualToString:@"industry"])
                            [self.delegate IndustryReceived:linkedinIndustry];
                        else
                            if ([valueCalled isEqualToString:@"position"])
                            [self.delegate threeCurrentPositions:linkedinCurrentThreePositions];
    
}

@end
