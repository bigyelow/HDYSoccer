//
//  ContactAndCostCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ContactCell.h"
#import "GameListFilterTableViewCell.h"

// image
#define CONTACT_IMAGE_LEFT_MARGIN 10.0F
#define CONTACT_IMAGE_TOP_MARGIN 15.0F
#define CONTACT_IMAGE_WIDTH 13.0F
#define CONTACT_IMAGE_HEIGHT 13.0F

// title
#define TITLE_LEFT_MARGIN 11.0f

// text field
#define TEXT_FIELD_LEFT_MARGIN 5.0f
#define TEXT_FIELD_WIDTH 200.0
#define TEXT_FIELD_HEIGHT 30.0f

@implementation ContactCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              title:(NSString *)title
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // contact image
    UIImage *contactImage = [UIImage imageNamed:@"phone2-75.png"];
    CGRect contactRect = CGRectMake(CONTACT_IMAGE_LEFT_MARGIN, CONTACT_IMAGE_TOP_MARGIN, CONTACT_IMAGE_WIDTH, CONTACT_IMAGE_HEIGHT);
    UIImageView *contactView = [[UIImageView alloc] initWithFrame:contactRect];
    [contactView setImage:contactImage];
    
    [self addSubview:contactView];
    
    // title
    CGFloat titleX = CGRectGetMaxX(contactView.frame) + TITLE_LEFT_MARGIN;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 0, 0, 0)];
    [titleLabel setText:title];
    [titleLabel sizeToFit];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:titleLabel];
    
    [self addSubview:titleLabel];
    
    // text field
    CGFloat fieldX = CGRectGetMaxX(titleLabel.frame) + TEXT_FIELD_LEFT_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, 0, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:fieldRect];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setTintColor:[UIColor blackColor]];
    [textField.layer setBorderWidth:1.0f];
    [textField.layer setCornerRadius:5.0f];
    [textField.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:textField];
    
    self.textField = textField;
    [self addSubview:textField];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // seperator line
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    
    [self addSubview:seperator];
  }
  return self;
}

- (void)awakeFromNib
{
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
