//
//  SettingsViewController.h
//  Crazyflie client
//
//  Created by Arnaud Taffanel on 11/1/14.
//  Copyright (c) 2014 Bitcraze. All rights reserved.
//

#import <UIKit/UIKit.h>
<<<<<<< HEAD
=======
#import <CoreMotion/CoreMotion.h>

double accelX;
double accelY;
double accelZ;

double gyroX;
double gyroY;
double gyroZ;


>>>>>>> merge_branch

@protocol SettingsProtocolDelegate <NSObject>

@required
- (void) closeButtonPressed;
@end

@interface SettingsViewController : UIViewController

@property (nonatomic, strong) id delegate;

@property (weak, nonatomic) IBOutlet UITextField *pitchrollSensitivity;
@property (weak, nonatomic) IBOutlet UITextField *thrustSensitivity;
@property (weak, nonatomic) IBOutlet UITextField *yawSensitivity;
<<<<<<< HEAD
@property (weak, nonatomic) IBOutlet UISegmentedControl *sensitivitySelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *controlModeSelector;

=======


@property (weak, nonatomic) IBOutlet UITextField *rollBias;
@property (weak, nonatomic) IBOutlet UITextField *pitchBias;
@property (weak, nonatomic) IBOutlet UITextField *yawBias;


@property (weak, nonatomic) IBOutlet UISegmentedControl *sensitivitySelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *controlModeSelector;

@property (weak, nonatomic) IBOutlet UILabel *labelRoll;
@property (weak, nonatomic) IBOutlet UILabel *labelPitch;
@property (weak, nonatomic) IBOutlet UILabel *labelYaw;

//coremotion stuff
@property (weak, nonatomic) IBOutlet UITextField *roll;


>>>>>>> merge_branch
@property () NSInteger controlMode;
@property (strong, nonatomic) NSMutableDictionary *sensitivities;
@property (weak, nonatomic) NSString *sensitivitySetting;

<<<<<<< HEAD
=======
//attempting to initialize motionmanager
@property (strong, nonatomic) CMMotionManager *motionManager;

>>>>>>> merge_branch
@end
