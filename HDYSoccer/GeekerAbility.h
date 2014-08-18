//
//  GeekerAbility.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"
#import "ComprehensiveAbility.h"
#import "SkillAbility.h"
#import "QualityAbility.h"

@interface GeekerAbility : BaseObject

@property (nonatomic, strong) ComprehensiveAbility *comprehensiveAbility;
@property (nonatomic, strong) SkillAbility *skillAbility;
@property (nonatomic, strong) QualityAbility *qualityAbility;

@end
