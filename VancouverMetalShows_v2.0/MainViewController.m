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

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.db = [FIRFirestore firestore];
    [self getCollection];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) getCollection{
    __block int i = 0;
    
    UIScrollView *imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 130,
                                                                                  self.view.frame.size.width,
                                                                                  self.view.frame.size.height-220)];
    imageScrollView.pagingEnabled = YES;
    
    [[self.db collectionWithPath:@"vms"]
         getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot,
                                      NSError * _Nullable error) {

           if (error != nil) {
             //NSLog(@"Error getting documents: %@", error);
           } else {
             for (FIRDocumentSnapshot *document in snapshot.documents) {
               //NSLog(@"%@ => %@", document.documentID, document.data);


                 NSString *artist = [document.data objectForKey:@"artist"];
                 //NSLog(@"art: %@",artist);
                 NSString *date = [document.data objectForKey:@"date"];
                 NSString *supp_art = [document.data objectForKey:@"supporting_artists"];
                 NSString *tix = [document.data objectForKey:@"tickets"];
                 NSString *venue = [document.data objectForKey:@"venue"];

                 ShowModel *show = [[ShowModel alloc] initWithArtist: artist withDate:date withVenue:venue withSupportingArtists:supp_art withTickets:tix withImage:@""];
                 
                 CGFloat xOrigin = i*self.view.frame.size.width;
                 i++;
                 
                UILabel *infoLabel = [[UILabel alloc]  initWithFrame:CGRectMake(xOrigin, 280, self.view.frame.size.width, 50)];
                 
                 infoLabel.numberOfLines=2;
                 NSString *showInfo = [NSString stringWithString:show.artist];
                 showInfo = [showInfo stringByAppendingString:@"\n"];
                 showInfo = [showInfo stringByAppendingString:show.date];
                 //NSLog(@"showInfo: %@", showInfo);
                 infoLabel.text = showInfo;
                 infoLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:18];
                 infoLabel.textColor = [UIColor whiteColor];
                 
                
                infoLabel.textAlignment = NSTextAlignmentCenter;

                 [imageScrollView addSubview:infoLabel];
                 
                 NSString *imgName = [NSString stringWithString: show.artist];
                 imgName = [imgName stringByAppendingString:@"1"];
                 imgName = imgName.lowercaseString;
                 //NSLog(@"imgNam: %@",imgName);
                 
                 UIImage *img = [UIImage imageNamed:imgName];
                 UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(xOrigin, -140, self.view.frame.size.width, self.view.frame.size.height)];
                image.image = img;
                image.contentMode = UIViewContentModeScaleAspectFit;
                 
                [imageScrollView addSubview:image];
            
             }
           }
         }];
    
    imageScrollView.backgroundColor = [UIColor blackColor];
    imageScrollView.contentSize = CGSizeMake(self.view.frame.size.width*3, self.view.frame.size.height-220);
    [self.view addSubview:imageScrollView];
    
}


@end
