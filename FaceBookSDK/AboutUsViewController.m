//
//  AboutUsViewController.m
//  FaceBookSDK
//
//  Created by 10times on 23/01/17.
//  Copyright © 2017 Ankit Teotia. All rights reserved.
//

#import "AboutUsViewController.h"
#import "SWRevealViewController.h"

@interface AboutUsViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation AboutUsViewController
{
    NSArray *ArrContent;
}
@synthesize array;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sideBarButton setTarget: self.revealViewController];
        [self.sideBarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }

    self.aboutUsTableView.delegate = self;
    self.aboutUsTableView.dataSource = self;
    
    self.array = [[NSMutableDictionary alloc] init];
    
    NSString *localizedRateUsString = NSLocalizedString(@"Rate Us On AppStore", @"");
    NSString *localizedPrivacyString = NSLocalizedString(@"Privacy Policy", @"");

ArrContent = [[NSArray alloc] initWithObjects:localizedRateUsString,localizedPrivacyString, nil];

    NSString *localizedAboutUsString = NSLocalizedString(@"10times is the world's largest service provider for business events. We are using technology to change the way our millions of users discover and experience events. Spread across 10,000 cities, we are in the process of developing a cutting edge mobile technology in order to re-invent how this industry conducts business. Whether its a tradeshow or conference, we have it all on a single freakishly amazing platform!", @"");

    NSString *Str = localizedAboutUsString;
    
    NSString*strAdd = @"\n\nAddress :\n\n10 Times online Pvt Ltd, E-75, Noida sec 63, Uttar Pradesh";
    
    self.aboutUsText.text = [NSString stringWithFormat:@"%@,%@",Str,strAdd];
    
    [self calculateHeightForString: self.aboutUsText.text];
    
}

- (CGSize)calculateHeightForString:(NSString *)str
{
    CGSize size = CGSizeZero;
    
    UIFont *labelFont = [UIFont systemFontOfSize:17.0f];
    
    NSDictionary *systemFontAttrDict = [NSDictionary dictionaryWithObject:labelFont forKey:NSFontAttributeName];
    
    NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:str attributes:systemFontAttrDict];
    
    CGRect rect = [message boundingRectWithSize:(CGSize){320, MAXFLOAT}
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                        context:nil];
    
    size = CGSizeMake(rect.size.width, rect.size.height + 5);
    
    return size;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *MyIdentifier = @"aboutUs";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:MyIdentifier];
    }
    
    cell.textLabel.text = [ArrContent objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [ArrContent count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [ArrContent objectAtIndex:indexPath.row];
    
    if (indexPath.row == 0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=820954054&pageNumber=0&sortOrdering=2&type=Purple+Software&mt=8"]];
    }
    
    if (indexPath.row == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://10times.com/privacy-policy"]];
    }
}

- (IBAction)checkForUpdate:(id)sender {
    
    NSString *iTunesLink = @"https://itunes.apple.com/us/app/apple-store/id820954054?mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
