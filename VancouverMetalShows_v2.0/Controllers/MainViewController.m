//
//  MainViewController.m
//  VancouverMetalShows_v2.0
//

#import "MainViewController.h"
@import Firebase;
#import "ShowModel.h"
#import "FavouritesTableViewController.h"

@interface MainViewController()

@property (nonatomic, readwrite) FIRFirestore *db;
@property(nonatomic,strong) UILabel *infoLabel;
@property(nonatomic,strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *outerView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _outerView = [UIView new];
    
    self.db = [FIRFirestore firestore];
    [self setupScrollView];
    [self ShowAlert:@"Swipe->"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupScrollView{
    __block int i = 0;

    UIScrollView *imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130,
                                                                                  self.view.frame.size.width,
                                                                                  self.view.frame.size.height-250)];
    __block
    UIImage *img;
    
    [_outerView addSubview:imageScrollView];
    _outerView.backgroundColor = [UIColor blueColor];
    
    imageScrollView.pagingEnabled = YES;
    
    [[self.db collectionWithPath:@"vms"]
         getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot,
                                      NSError * _Nullable error) {

           if (error != nil)
           {
             //NSLog(@"Error getting documents: %@", error);
           } else {
             for (FIRDocumentSnapshot *document in snapshot.documents)
             {


                 NSString *artist = [document.data objectForKey:@"artist"];
                 //NSLog(@"art: %@",artist);
                 NSString *date = [document.data objectForKey:@"date"];
                 NSString *supp_art = [document.data objectForKey:@"supporting_artists"];
                 NSString *tix = [document.data objectForKey:@"tickets"];
                 NSString *venue = [document.data objectForKey:@"venue"];

                 ShowModel *show = [[ShowModel alloc] initWithArtist: artist withDate:date withVenue:venue withSupportingArtists:supp_art withTickets:tix withImage:@""];
                 
                 CGFloat xOrigin = i*self.view.frame.size.width;
                 i++;
                 
                 self.infoLabel = [[UILabel alloc]  initWithFrame:CGRectMake(xOrigin, imageScrollView.frame.size.height-75, self.view.frame.size.width, 50)];
                 
            
                 self.infoLabel.numberOfLines=2;
                 NSString *showInfo = [NSString stringWithString:show.artist];
                 showInfo = [showInfo stringByAppendingString:@"\n"];
                 showInfo = [showInfo stringByAppendingString:show.date];
                 //NSLog(@"showInfo: %@", showInfo);
                 self.infoLabel.text = showInfo;
                 self.infoLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
                 self.infoLabel.textColor = [UIColor whiteColor];
                 
                self.infoLabel.textAlignment = NSTextAlignmentCenter;

                 [imageScrollView addSubview:self.infoLabel];
                 
                 
                 NSString *imgName = [NSString stringWithString: show.artist];
                 imgName = [imgName stringByAppendingString:@"1"];
                 imgName = imgName.lowercaseString;
                 //NSLog(@"imgNam: %@",imgName);
                 
                img = [UIImage imageNamed:imgName];
                 
                self.imageView= [[UIImageView alloc]initWithFrame:CGRectMake(xOrigin, -150, self.view.frame.size.width, self.view.frame.size.height)];
                self.imageView.image = img;
                self.imageView.contentMode = UIViewContentModeScaleAspectFit;
                 
                [imageScrollView addSubview:self.imageView];
            
             }
           }
         }];
    

    
    imageScrollView.backgroundColor = [UIColor blackColor];
    imageScrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height-250);
    [self.view addSubview:imageScrollView];
    
    //[imageScrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:30].active=YES;
    
}

- (void) ShowAlert:(NSString *)Message {
    UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil
                                                                  message:@""
                                                           preferredStyle:UIAlertControllerStyleAlert];
    
    alert.view.opaque = false;
    UIView *firstSubview = alert.view.subviews.firstObject;
    UIView *alertContentView = firstSubview.subviews.firstObject;
    for (UIView *subSubView in alertContentView.subviews) {
        //subSubView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
        subSubView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
        
        subSubView.opaque = false;
    }
    NSMutableAttributedString *AS = [[NSMutableAttributedString alloc] initWithString:Message];
    
    
    [AS addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0,AS.length)];

    [alert setValue:AS forKey:@"attributedTitle"];

    [self presentViewController:alert animated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alert dismissViewControllerAnimated:YES completion:^{
        }];
    });
}


@end
