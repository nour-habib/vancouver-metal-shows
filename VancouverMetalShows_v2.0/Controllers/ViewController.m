//
//  ViewController.m
//  VancouverMetalShows_v2.0

//  Created by Nour Habib on 2021-05-02.
//  Copyright © 2021 Nour. All rights reserved.

#import "ViewController.h"
#import "ShowModel.h"
#import "ShowTableViewCell.h"
#import "DetailViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableArray *modelsArray;
@property(nonatomic, strong) UIBarButtonItem *backBarButtonItem;
@property (strong,nonatomic) NSMutableArray *imagesArray;
@property(strong,nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic) NSMutableArray *searchResultsArray;
@property (nonatomic, assign) BOOL isFiltered;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.modelsArray = [NSMutableArray new];
    self.imagesArray = [NSMutableArray new];
    self.isFiltered = false;
    self.searchBar.delegate = self;
    
    [self urlRequest];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *) searchText{
 
    if(searchText.length==0)
    {
        _isFiltered=false;
    }
    else{
        _isFiltered=true;
        _searchResultsArray = [[NSMutableArray alloc]init];
        for(ShowModel *show in _modelsArray)
        {
            NSRange nameRange = [show.artist rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound)
            {
                //NSLog(@"Search: %@", show.artist);
                [_searchResultsArray addObject:show];
        
            }
        }
    }
    
    [self.tableView reloadData];
}

-(void) urlRequest{
    //NSLog(@"urlRequest");
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
    
    for (NSDictionary *showDict in jsonArray)
    {
        
        NSString *artist = [showDict objectForKey:@"artist"];
        NSString *date = [showDict objectForKey:@"date"];
        NSString *venue = [showDict objectForKey:@"venue"];
        NSString *supporting_artists = [showDict objectForKey:@"supporting_artists"];
        NSString *tickets = [showDict objectForKey:@"tickets"];
        NSString *artist_image = [showDict objectForKey:@"artist_image"];
    
        ShowModel *showModel = [[ShowModel alloc] initWithArtist: artist withDate:date withVenue:venue withSupportingArtists:supporting_artists withTickets:tickets withImage:artist_image];
        
        [self.modelsArray addObject:showModel];
        
    }
    
    for(ShowModel *m in _modelsArray)
    {
        [_imagesArray addObject:m.artistImage];
        
        NSString *dateStr = m.date;
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
        dateFormat.timeStyle = NSDateFormatterNoStyle;
        dateFormat.dateStyle = NSDateFormatterMediumStyle;
        [dateFormat setDateFormat: @"yyyy-MM-dd"];
        
        NSDate *date = [dateFormat dateFromString:dateStr];
        dateFormat.dateFormat = @"EEEE, MMM d, yyyy";
        NSString *st = [dateFormat stringFromDate:date];
        //NSLog(@"st: %@", st);
        m.date = st;
        
    }
    
//    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc]
//                                        initWithKey: @"date" ascending: YES];
//    NSArray *sortedArray = [self.modelsArray sortedArrayUsingDescriptors: [NSArray arrayWithObject:sortDescriptor]];
//    _modelsArray = [NSMutableArray arrayWithArray:sortedArray];
    
//    for(ShowModel *m in _modelsArray)
//    {
//        NSLog(@"Date: %@", m.date);
//    }
    
 
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(_isFiltered)
    {
        return _searchResultsArray.count;
    }
    return [self.modelsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];//
    if(cell==nil)
    {
        //NSLog(@"nil");
        cell = [[ShowTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if(_isFiltered)
    {
        //NSLog(@"isFiltered");
        
        ShowModel *m = self.searchResultsArray[indexPath.row];
        cell.showModel = m;
        cell.imageView.image = [UIImage imageNamed:m.artistImage];
    }
    else
    {
        ShowModel *model = self.modelsArray[indexPath.row];
        cell.showModel = model;
        cell.imageView.image = [UIImage imageNamed:[_imagesArray objectAtIndex:indexPath.row]];
        
    }
    
    
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"showConcertDetail" sender:tableView];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showConcertDetail"]) {
       NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DetailViewController *detailViewController = segue.destinationViewController;
        
        ShowModel *model = [_modelsArray objectAtIndex:indexPath.row];
        
        //NSLog(@"artistLabel: %@", model.artist);
        detailViewController.showModel = model;
        
        
    }
    
}

@end
