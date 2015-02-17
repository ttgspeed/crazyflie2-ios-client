/*
 *    ||          ____  _ __                           
 * +------+      / __ )(_) /_______________ _____  ___ 
 * | 0xBC |     / __  / / __/ ___/ ___/ __ `/_  / / _ \
 * +------+    / /_/ / / /_/ /__/ /  / /_/ / / /_/  __/
 *  ||  ||    /_____/_/\__/\___/_/   \__,_/ /___/\___/
 *
 * Crazyflie ios client
 *
 * Copyright (C) 2014 BitCraze AB
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, in version 3.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * ViewController.h: View controller
 */

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "SettingsViewController.h"

@interface ViewController : UIViewController <CBCentralManagerDelegate,
                                              CBPeripheralDelegate,
                                              SettingsProtocolDelegate>

@property (weak, nonatomic) IBOutlet UISwitch *autoHover;

@property (nonatomic) BOOL isHovering;

@property (nonatomic) BOOL biasLocked;
@property (nonatomic, assign) float biasRoll;
@property (nonatomic, assign) float biasPitch;
@property (nonatomic, assign) float biasYaw;


@property (nonatomic, assign) int lastThrottle;

//attempting to initialize motionmanager
@property (strong, nonatomic) CMMotionManager *motionManager;

@property (weak, nonatomic) IBOutlet UILabel *labelRoll;
@property (weak, nonatomic) IBOutlet UILabel *labelPitch;
@property (weak, nonatomic) IBOutlet UILabel *labelYaw;

@property (weak, nonatomic) IBOutlet UILabel *labelRoll2;
@property (weak, nonatomic) IBOutlet UILabel *labelPitch2;
@property (weak, nonatomic) IBOutlet UILabel *labelYaw2;


@end
