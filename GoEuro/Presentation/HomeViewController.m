//
//  HomeViewController.m
//  GoEuro
//
//  Created by Mohamed Magdy on 6/8/16.
//  Copyright © 2016 Magdy. All rights reserved.
//

#import "HomeViewController.h"
#import "APIManager.h"
#import "Constants.h"
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController () <UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *originTextField;
@property (weak, nonatomic) IBOutlet UITextField *destinationTextField;
@property (weak, nonatomic) IBOutlet UITableView *originCitiesTableView;
@property (weak, nonatomic) IBOutlet UITableView *destinationCitiesTableView;

@property (nonatomic,strong) NSArray *locations;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customizeAppearance];
    [self getUserLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) customizeAppearance {
    _originCitiesTableView.hidden = YES;
    _destinationCitiesTableView.hidden = YES;
}
-(void) getUserLocation {
    
    CLLocationManager *locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startUpdatingLocation];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_originTextField resignFirstResponder];
    [_destinationTextField resignFirstResponder];
}

- (IBAction)textFieldEditingChanged:(UITextField *)sender {
    
    if (sender.text.length >= 1){
        APIManager *manager = [APIManager sharedInstance];
        
        [manager getCitiesForSearchText:sender.text withSuccess:^(Location *location) {
            _locations = location.locations;
            if ([sender isEqual:_originTextField]){
                _originCitiesTableView.hidden = NO;
                _destinationCitiesTableView.hidden = YES;
                [_originCitiesTableView reloadData];
            }
            else if ([sender isEqual:_destinationTextField]){
                _destinationCitiesTableView.hidden = NO;
                _originCitiesTableView.hidden = YES;
                [_destinationCitiesTableView reloadData];
            }
            
        } failure:^(NSError *error) {
            [self showErrorMessage:error.localizedDescription];
        }];

    }
    
}

-(void) showErrorMessage:(NSString*)message {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark = CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [manager stopUpdatingLocation];
    CLLocation *location = locations.lastObject;
    [APIManager sharedInstance].usersLocation = location;
    
}

#pragma mark - UITableViewDataSource Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _locations.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifer;
    
    if ([tableView isEqual:_originCitiesTableView]){
        cellIdentifer = originCitiesCell;
    }
    
    else {
        cellIdentifer = destinationCitiesCell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    Locations *location = [_locations objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@, %@",location.name,location.country];
    
    return cell;
}


#pragma mark - UITextFieldDelegate Methods
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
