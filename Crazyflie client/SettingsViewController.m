//
//  SettingsViewController.m
//  Crazyflie client
//
//  Created by Arnaud Taffanel on 11/1/14.
//  Copyright (c) 2014 Bitcraze. All rights reserved.
//

#import "SettingsViewController.h"

<<<<<<< HEAD
=======
@import CoreMotion;

@interface CMDeviceMotion ()
@property (nonatomic, strong) CMMotionManager * motionManager;
@property (nonatomic, strong) UIView * ball;
@end

>>>>>>> merge_branch
@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *leftYLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftXLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightYLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightXLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Init button border color
    _closeButton.layer.borderColor = [_closeButton tintColor].CGColor;
    
    if ([self.sensitivitySetting isEqualToString:@"slow"])
        self.sensitivitySelector.selectedSegmentIndex = 0;
    else if ([self.sensitivitySetting isEqualToString:@"fast"])
        self.sensitivitySelector.selectedSegmentIndex = 1;
    else if ([self.sensitivitySetting isEqualToString:@"custom"])
        self.sensitivitySelector.selectedSegmentIndex = 2;
    
    self.controlModeSelector.selectedSegmentIndex = self.controlMode-1;
    
    [self sensitivityChanged:self.sensitivitySelector];
    [self modeChanged:self.controlModeSelector];
    
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)]];
<<<<<<< HEAD
}

=======
    
    //begin drone stuff
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateDeviceMotion) userInfo:nil repeats:YES];
    
    self.motionManager = [[CMMotionManager alloc] init]; self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
    
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame: CMAttitudeReferenceFrameXArbitraryCorrectedZVertical];
    
    

}
//Core Motion methods
-(void)updateDeviceMotion;
{
    CMDeviceMotion *deviceMotion = self.motionManager.deviceMotion;
    
    if(deviceMotion == nil)
    {
        return;
    }
    
    CMAttitude *attitude = deviceMotion.attitude;
    CMAcceleration userAcceleration = deviceMotion.userAcceleration;
    
    self.labelRoll.text = [NSString stringWithFormat:@"%f",attitude.roll];
    self.labelPitch.text = [NSString stringWithFormat:@"%f",attitude.pitch];
    self.labelYaw.text = [NSString stringWithFormat:@"%f",attitude.yaw];
}



//end core motion methods



//accel drone display
-(void) outputAccelInfo
{
    
}

//gyro drone display
-(void) outputGyroInfo
{
    
}



>>>>>>> merge_branch
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeClicked:(id)sender {
    if (self.delegate) {
        [self.delegate closeButtonPressed];
    }
}
- (IBAction)sensitivityChanged:(id)sender {
    NSArray *selectorNames = @[@"slow", @"fast", @"custom"];
    
    self.sensitivitySetting = selectorNames[self.sensitivitySelector.selectedSegmentIndex];
    NSDictionary *sensitivity =  [self.sensitivities valueForKey:self.sensitivitySetting];
    
    self.pitchrollSensitivity.text = [[sensitivity valueForKey:@"pitchRate"] stringValue];
    self.thrustSensitivity.text = [[sensitivity valueForKey:@"maxThrust"] stringValue];
    self.yawSensitivity.text = [[sensitivity valueForKey:@"yawRate"] stringValue];
    
<<<<<<< HEAD
=======
    self.rollBias.text = [[sensitivity valueForKey:@"rollBias"] stringValue];
    self.pitchBias.text = [[sensitivity valueForKey:@"pitchBias"] stringValue];
    self.yawBias.text = [[sensitivity valueForKey:@"yawBias"] stringValue];

    self.rollBias.enabled = YES;
    self.pitchBias.enabled = YES;
    self.yawBias.enabled = YES;
    
>>>>>>> merge_branch
    switch (self.sensitivitySelector.selectedSegmentIndex) {
        case 0:
        case 1:
            self.pitchrollSensitivity.enabled = NO;
            self.thrustSensitivity.enabled = NO;
            self.yawSensitivity.enabled = NO;
<<<<<<< HEAD
=======
            //self.rollBias.enabled = NO;
>>>>>>> merge_branch
            break;
        case 2:
            self.pitchrollSensitivity.enabled = YES;
            self.thrustSensitivity.enabled = YES;
            self.yawSensitivity.enabled = YES;
<<<<<<< HEAD
=======
            //self.rollBias.enabled = YES;
>>>>>>> merge_branch
            break;
    }
}
- (IBAction)modeChanged:(id)sender {
    static const NSString *mode2str[4][4] = {{@"Yaw",  @"Pitch",  @"Roll", @"Thrust"},
        {@"Yaw",  @"Thrust", @"Roll", @"Pitch"},
        {@"Roll", @"Pitch",  @"Yaw",  @"Thrust"},
        {@"Roll", @"Thrust", @"Yaw",  @"Pitch"}};
    
    self.controlMode = (int)self.controlModeSelector.selectedSegmentIndex+1;
    
    _leftXLabel.text = [mode2str[_controlMode-1][0] copy];
    _leftYLabel.text = [mode2str[_controlMode-1][1] copy];
    _rightXLabel.text = [mode2str[_controlMode-1][2] copy];
    _rightYLabel.text = [mode2str[_controlMode-1][3] copy];
}

- (IBAction)endEditing:(id)sender {
    if ([self.sensitivitySetting isEqualToString:@"custom"]) {
        //Check settings range and correct them automatically if required
        NSInteger pitchRate = [self.pitchrollSensitivity.text integerValue];
        NSInteger yawRate = [self.yawSensitivity.text integerValue];
        NSInteger maxThrust = [self.thrustSensitivity.text integerValue];
        
<<<<<<< HEAD
=======
        NSInteger rollBias = [self.rollBias.text integerValue];
        NSInteger pitchBias = [self.pitchBias.text integerValue];
        NSInteger yawBias = [self.yawBias.text integerValue];
        
>>>>>>> merge_branch
        if (pitchRate<0)
            pitchRate = 0;
        if (pitchRate>80)
            pitchRate = 80;
        if (yawRate<0)
            yawRate = 0;
        if (yawRate>500)
            yawRate = 500;
        if (maxThrust<0)
            maxThrust = 0;
        if (maxThrust>100)
            maxThrust = 100;
        
        // Write the correctef values
        self.pitchrollSensitivity.text = [NSString stringWithFormat:@"%ld", (long)pitchRate];
        self.yawSensitivity.text = [NSString stringWithFormat:@"%ld", (long)yawRate];
        self.thrustSensitivity.text = [NSString stringWithFormat:@"%ld", (long)maxThrust];
        
<<<<<<< HEAD
        NSDictionary * customSensitivity = @{@"pitchRate": [NSNumber numberWithLong:pitchRate],
                                             @"yawRate": [NSNumber numberWithLong:yawRate],
                                             @"maxThrust": [NSNumber numberWithLong:maxThrust]};
=======
        self.rollBias.text = [NSString stringWithFormat:@"%ld", (long)rollBias];
        self.pitchBias.text = [NSString stringWithFormat:@"%ld", (long)pitchBias];
        self.yawBias.text = [NSString stringWithFormat:@"%ld", (long)yawBias];
        
        NSDictionary * customSensitivity = @{@"pitchRate": [NSNumber numberWithLong:pitchRate],
                                             @"yawRate": [NSNumber numberWithLong:yawRate],
                                             @"maxThrust": [NSNumber numberWithLong:maxThrust],
                                             @"rollBias": [NSNumber numberWithLong:rollBias],
                                             @"pitchBias": [NSNumber numberWithLong:pitchBias],
                                             @"yawBias": [NSNumber numberWithLong:yawBias]};
>>>>>>> merge_branch

        [self.sensitivities setValue:customSensitivity forKey:@"custom"];
    }
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
