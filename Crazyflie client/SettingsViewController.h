//
//  SettingsViewController.h
//  Crazyflie client
//
//  Created by Arnaud Taffanel on 11/1/14.
//  Copyright (c) 2014 Bitcraze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

double accelX;
double accelY;
double accelZ;

double gyroX;
double gyroY;
double gyroZ;



@protocol SettingsProtocolDelegate <NSObject>

@required
- (void) closeButtonPressed;
@end

@interface SettingsViewController : UIViewController

@property (nonatomic, strong) id delegate;

@property (weak, nonatomic) IBOutlet UITextField *pitchrollSensitivity;
@property (weak, nonatomic) IBOutlet UITextField *thrustSensitivity;
@property (weak, nonatomic) IBOutlet UITextField *yawSensitivity;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sensitivitySelector;
@property (weak, nonatomic) IBOutlet UISegmentedControl *controlModeSelector;

@property (weak, nonatomic) IBOutlet UILabel *labelRoll;
@property (weak, nonatomic) IBOutlet UILabel *labelPitch;
@property (weak, nonatomic) IBOutlet UILabel *labelYaw;

@property (weak, nonatomic) IBOutlet UILabel *labelAccX;
@property (weak, nonatomic) IBOutlet UILabel *labelAccY;
@property (weak, nonatomic) IBOutlet UILabel *labelAccZ;

//coremotion stuff
@property (weak, nonatomic) IBOutlet UITextField *roll;


@property () NSInteger controlMode;
@property (strong, nonatomic) NSMutableDictionary *sensitivities;
@property (weak, nonatomic) NSString *sensitivitySetting;

//attempting to initialize motionmanager
@property (strong, nonatomic) CMMotionManager *motionManager;

@end
