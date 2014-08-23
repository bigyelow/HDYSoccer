//
//  HDYSoccerMenuViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerMenuViewController.h"
#import "HDYSoccerMenuViewController+UIConfiguration.h"
#import "MenuViewParams.h"
#import "HDYSoccerNavigationController.h"
#import "HDYSoccerGeekerViewController.h"
#import "AppDelegate.h"

@interface HDYSoccerMenuViewController ()

@end

@implementation HDYSoccerMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self configTableView];
  [self configTableHeaderView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - table view delegate & datasource
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  cell.backgroundColor = [UIColor clearColor];
  cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
  cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
  return nil;
  
  /*
  if (sectionIndex == 0)
    return nil;
  
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
  view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
  label.text = @"Friends Online";
  label.font = [UIFont systemFontOfSize:15];
  label.textColor = [UIColor whiteColor];
  label.backgroundColor = [UIColor clearColor];
  [label sizeToFit];
  [view addSubview:label];
  
  return view;
   */
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
  return 0;
  
  /*
  if (sectionIndex == 0)
    return 0;
  
  return 34;
   */
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return TABLE_CELL_HEIGHT;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
  return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
  
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
  }
  
  NSArray *titles = @[CELL_TITLE_PLAY, CELL_TITLE_MINE, CELL_TITLE_STADUM, CELL_TITLE_TACTICAL_BOARD];
  UILabel *label = [UIConfiguration labelWithText:titles[indexPath.row]
                                        textColor:[UIColor blackColor]
                                             font:[UIFont systemFontOfSize:17]
                                    numberOfLines:1];
  [UIConfiguration setView:label origin:CGPointMake(15, 23)];
  
  [cell addSubview:label];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  switch (indexPath.section) {
    case 0:
      switch (indexPath.row) {
        case 0: {
          self.frostedViewController.contentViewController = APP_DELEGATE.gameNav;
        }
          break;
          
        case 1:{
          self.frostedViewController.contentViewController = APP_DELEGATE.geekerNav;
        }
          break;
          
        default:
          break;
      }
      break;
      
    default:
      break;
  }
  
  [self.frostedViewController hideMenuViewController];
}

#pragma mark - login delegate

- (void)loginSucceeded:(RegisterAndLoginViewController *)vc
{
  [self configTableHeaderView];
  [Tools performAfterDelay:1 block:^{
    [vc dismissViewControllerAnimated:YES completion:nil];
  }];
}

@end
