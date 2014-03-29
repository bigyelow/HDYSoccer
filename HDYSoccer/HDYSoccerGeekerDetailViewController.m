//
//  HDYSoccerGeekerDetailViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController.h"

@interface HDYSoccerGeekerDetailViewController ()

@end

@implementation HDYSoccerGeekerDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (id)initWithGeeker:(NSString *)geekerName
{
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    self.geekerName = geekerName;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  self.title = self.geekerName;
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
