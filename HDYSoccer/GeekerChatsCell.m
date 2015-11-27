//
//  GeekerChatsCell.m
//  HDYSoccer
//
//  Created by XueMing on 11/27/15.
//  Copyright © 2015 bigyelow. All rights reserved.
//

#import "GeekerChatsCell.h"
#import "UUChart.h"

@interface GeekerChatsCell () <UUChartDataSource>

@property (nonatomic, strong) NSIndexPath *path;
@property (nonatomic, strong) UUChart *chartView;

@end

@implementation GeekerChatsCell

- (void)configUI:(NSIndexPath *)indexPath
{
  if (self.chartView) {
    [self.chartView removeFromSuperview];
    [self setChartView:nil];
  }

  self.path = indexPath;
  self.chartView = [[UUChart alloc] initwithUUChartDataFrame:CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width-20, 150)
                                                  withSource:self
                                                   withStyle:UUChartLineStyle];
  [self.chartView showInView:self.contentView];
}

- (NSArray *)getXTitles:(int)num
{
  NSMutableArray *xTitles = [NSMutableArray array];
  for (int i=0; i<num; i++) {
    NSString * str = [NSString stringWithFormat:@"M-%d",i + 1];
    [xTitles addObject:str];
  }
  return xTitles;
}

#pragma mark - @required
//横坐标标题数组
- (NSArray *)UUChart_xLableArray:(UUChart *)chart
{
  return [self getXTitles:6];
}

//数值多重数组
- (NSArray *)UUChart_yValueArray:(UUChart *)chart
{
  NSArray *ary1 = @[@"65",@"67",@"45",@"50",@"58",@"65",@"60"];
  NSArray *ary2 = @[@"85",@"65",@"60",@"55",@"40",@"80",@"88"];
  return @[ary1, ary2];
}

#pragma mark - @optional
//颜色数组
- (NSArray *)UUChart_ColorArray:(UUChart *)chart
{
  return @[UUGreen, UURed, UUBrown];
}

//显示数值范围
- (CGRange)UUChartChooseRangeInLineChart:(UUChart *)chart
{
  return CGRangeMake(100, 0);
}

#pragma mark 折线图专享功能

//标记数值区域
- (CGRange)UUChartMarkRangeInLineChart:(UUChart *)chart
{
  return CGRangeMake(25, 75);
}

//判断显示横线条
- (BOOL)UUChart:(UUChart *)chart ShowHorizonLineAtIndex:(NSInteger)index
{
  return YES;
}

//判断显示最大最小值
- (BOOL)UUChart:(UUChart *)chart ShowMaxMinAtIndex:(NSInteger)index
{
  return YES;
}

@end
