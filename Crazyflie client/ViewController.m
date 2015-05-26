/*
 *    ||          ____  _ __                           
 * +------+      / __ )(_) /_______________ _____  ___ 
 * | 0xBC |     / __  / / __/ ___/ ___/ __ `/_  / / _ \
 * +------+    / /_/ / / /_/ /__/ /  / /_/ / / /_/  __/
 *  ||  ||    /_____/_/\__/\___/_/   \__,_/ /___/\___/
 *
<<<<<<< HEAD
 * Crazyflie ios client
=======
 * Crazyflie iOS client
>>>>>>> merge_branch
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
 * ViewController.m: View controller. Handles app life cycle and BLE connection.
 */

#import "ViewController.h"
#import "BCJoystick.h"
#import <CoreBluetooth/CoreBluetooth.h>

<<<<<<< HEAD
#import <Crazyflie_client-Swift.h>
=======
#define CRAZYFLIE_SERVICE @"00000201-1C7F-4F9E-947B-43B7C00A9A08"
#define CRTP_CHARACTERISTIC @"00000202-1C7F-4F9E-947B-43B7C00A9A08"

>>>>>>> merge_branch

#define LINEAR_PR YES
#define LINEAR_THRUST YES

@interface ViewController () {
    BCJoystick *leftJoystick;
    BCJoystick *rightJoystick;
<<<<<<< HEAD
    bool sent;
=======
    bool canBluetooth;
    bool isScanning;
    bool sent;
    bool wasUnlocked;
    bool hovering;
    bool sink;
    bool sinking;
    bool skip;
>>>>>>> merge_branch
    
    bool locked;
    
    float pitchRate;
    float yawRate;
    float maxThrust;
<<<<<<< HEAD
    int controlMode;
    
    enum {stateIdle, stateScanning, stateConnecting, stateConnected} state;
    
=======
    float rollBias;
    float pitchBias;
    float yawBias;
    int sinkingThrust;
    int controlMode;
    int count;
    int sentinal;
    
    enum {stateIdle, stateScanning, stateConnecting, stateConnected} state;
    
    CBPeripheral *crazyflie;
    
    CBCentralManager *centralManager;
    
>>>>>>> merge_branch
    SettingsViewController *settingsViewController;
    
    NSMutableDictionary *sensitivities;
    NSString *sensitivitySetting;
}

@property (weak, nonatomic) IBOutlet UILabel *unlockLabel;
@property (weak, nonatomic) IBOutlet UIButton *connectButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UIProgressView *connectProgress;

@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *rightView;

<<<<<<< HEAD
@property (strong) BluetoothLink *bluetoothLink;

@property (strong) NSTimer *commanderTimer;
=======
@property (strong) CBPeripheral *connectingPeritheral;
@property (strong) CBCharacteristic *crtpCharacteristic;

@property (strong) NSTimer *commanderTimer;
@property (strong) NSTimer *scanTimer;

>>>>>>> merge_branch
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Init instance variables
    self.connectProgress.progress = 0;
    
<<<<<<< HEAD
    sent = NO;
    state = stateIdle;
    locked = YES;
=======
    canBluetooth = NO;
    isScanning = NO;
    sent = NO;
    state = stateIdle;
    locked = YES;
    sinking = false;
    sink = false;
    hovering = false;
>>>>>>> merge_branch
    
    //Init button border color
    _connectButton.layer.borderColor = [_connectButton tintColor].CGColor;
    _settingsButton.layer.borderColor = [_settingsButton tintColor].CGColor;
    
    //Init joysticks
    CGRect frame = [[UIScreen mainScreen] bounds];
    leftJoystick = [[BCJoystick alloc] initWithFrame:frame];
    [_leftView addSubview:leftJoystick];
    [leftJoystick addTarget:self action:@selector(joystickTouch:) forControlEvents:UIControlEventAllTouchEvents];
    
    rightJoystick = [[BCJoystick alloc] initWithFrame:frame];
    [_rightView addSubview:rightJoystick];
    [rightJoystick addTarget:self action:@selector(joystickTouch:) forControlEvents:UIControlEventAllTouchEvents];
    rightJoystick.deadbandX = 0.1;  //Some deadband for the yaw
    rightJoystick.vLabelLeft = YES;
    
    [self loadDefault];
    
<<<<<<< HEAD
    self.bluetoothLink = [[BluetoothLink alloc] init];

    // Update GUI when connection state changes
    [_bluetoothLink onStateUpdated: ^(NSString *newState) {
        if ([newState isEqualToString:@"idle"]) {
            [self.connectProgress setProgress:0 animated:NO];
            [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
        } else if ([newState isEqualToString:@"scanning"]) {
            [self.connectProgress setProgress:0 animated:NO];
            [self.connectButton setTitle:@"Cancel" forState:UIControlStateNormal];
        } else if ([newState isEqualToString:@"connecting"]) {
            [self.connectProgress setProgress:0.25 animated:YES];
            [self.connectButton setTitle:@"Cancel" forState:UIControlStateNormal];
        } else if ([newState isEqualToString:@"services"]) {
            [self.connectProgress setProgress:0.5 animated:YES];
            [self.connectButton setTitle:@"Cancel" forState:UIControlStateNormal];
        } else if ([newState isEqualToString:@"characteristics"]) {
            [self.connectProgress setProgress:0.75 animated:YES];
            [self.connectButton setTitle:@"Cancel" forState:UIControlStateNormal];
        } else if ([newState isEqualToString:@"connected"]) {
            [self.connectProgress setProgress:1 animated:YES];
            [self.connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
        }
    }];
=======
    centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateDeviceMotion) userInfo:nil repeats:YES];
    
    self.motionManager = [[CMMotionManager alloc] init]; self.motionManager.deviceMotionUpdateInterval = 1.0 / 60.0;
    
    [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame: CMAttitudeReferenceFrameXArbitraryCorrectedZVertical];
}

-(void)updateDeviceMotion;
{
    CMDeviceMotion *deviceMotion = self.motionManager.deviceMotion;
    
    if(deviceMotion == nil)
    {
        return;
    }
    
    CMAttitude *attitude = deviceMotion.attitude;
>>>>>>> merge_branch
}

- (void) loadDefault
{
    NSURL *defaultPrefsFile = [[NSBundle mainBundle] URLForResource:@"DefaultPreferences" withExtension:@"plist"];
    NSDictionary *defaultPrefs = [NSDictionary dictionaryWithContentsOfURL:defaultPrefsFile];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultPrefs];
    
    [self updateSettings:defaults];
}

- (void) saveDefault
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:[NSNumber numberWithInt:controlMode] forKey:@"controlMode"];
    [defaults setObject:sensitivities forKey:@"sensitivities"];
    [defaults setObject:sensitivitySetting forKey:@"sensitivitySettings"];
    
    [self updateSettings:defaults];
}

- (void) updateSettings: (NSUserDefaults*) defaults
{
<<<<<<< HEAD
    static const NSString *mode2str[4][4] = {{@"Yaw",  @"Pitch",  @"Roll", @"Thrust"},
                                             {@"Yaw",  @"Thrust", @"Roll", @"Pitch"},
                                             {@"Roll", @"Pitch",  @"Yaw",  @"Thrust"},
                                             {@"Roll", @"Thrust", @"Yaw",  @"Pitch"}};
=======

    static const NSString *mode2str[4] = {@"Yaw",  @"",  @"", @"Thrust"};
>>>>>>> merge_branch
    
    controlMode = [defaults doubleForKey:@"controlMode"];
    NSLog(@"controlMode %d", controlMode);
    sensitivities = (NSMutableDictionary*)[defaults dictionaryForKey:@"sensitivities"];
    sensitivitySetting = [defaults stringForKey:@"sensitivitySettings"];
    
    NSDictionary *sensitivity = (NSDictionary*)[sensitivities valueForKey:sensitivitySetting];
    pitchRate = [(NSNumber*)[sensitivity valueForKey:@"pitchRate"] floatValue];
    yawRate = [(NSNumber*)[sensitivity valueForKey:@"yawRate"] floatValue];
    maxThrust = [(NSNumber*)[sensitivity valueForKey:@"maxThrust"] floatValue];
    
<<<<<<< HEAD
    leftJoystick.hLabel.text = [mode2str[controlMode-1][0] copy];
    leftJoystick.vLabel.text = [mode2str[controlMode-1][1] copy];
    rightJoystick.hLabel.text = [mode2str[controlMode-1][2] copy];
    rightJoystick.vLabel.text = [mode2str[controlMode-1][3] copy];
=======
    rollBias = [(NSNumber*)[sensitivity valueForKey:@"rollBias"] floatValue];
    pitchBias = [(NSNumber*)[sensitivity valueForKey:@"pitchBias"] floatValue];
    yawBias = [(NSNumber*)[sensitivity valueForKey:@"yawBias"] floatValue];
    
    leftJoystick.hLabel.text = [mode2str[0] copy];
    leftJoystick.vLabel.text = [mode2str[1] copy];
    rightJoystick.hLabel.text = [mode2str[2] copy];
    rightJoystick.vLabel.text = [mode2str[3] copy];
>>>>>>> merge_branch
    
    leftJoystick.deadbandX = 0;
    rightJoystick.deadbandX = 0;
    if ([leftJoystick.hLabel.text isEqualToString:@"Yaw"]) {
        leftJoystick.deadbandX = 0.1;
    } else {
        rightJoystick.deadbandX = 0.1;
    }
    
    leftJoystick.positiveY = NO;
    rightJoystick.positiveY = NO;
    if ([leftJoystick.vLabel.text isEqualToString:@"Thrust"]) {
        leftJoystick.positiveY = YES;
    } else {
        rightJoystick.positiveY = YES;
    }
}

- (void) joystickMoved: (BCJoystick*)joystick
{
    NSLog(@"Joystick moved to %f,%f.", joystick.x, joystick.y);
}

-(void) joystickTouch:(BCJoystick *)jostick
{
    if (leftJoystick.activated && rightJoystick.activated) {
<<<<<<< HEAD
        self.unlockLabel.hidden = true;
        locked = NO;
    } else if (!leftJoystick.activated && !rightJoystick.activated) {
        self.unlockLabel.hidden = false;
        locked = YES;
    }
}

=======
        
        self.unlockLabel.text = @"Remove right thumb to autohover";
        locked = NO;
        self.biasLocked = TRUE;
        wasUnlocked = true;
        
        //if we were previously hovering, don't cut the thrust
        if (hovering)
        {
            sink = true;
            hovering = false;
        }
        skip = true;
        
       [self enableAutoHover:false];

    } else if (!leftJoystick.activated && !rightJoystick.activated) {
        
        self.unlockLabel.text = @"Place both thumbs to enable control";
        locked = YES;
        wasUnlocked = false;
        hovering = false;
        sinking = false;
        sink = false;
        skip = true;
       [self enableAutoHover:false];
    }
    else if (leftJoystick.activated && !rightJoystick.activated)
    {
        //enable autohover if only left stick is activated
        
        self.unlockLabel.text = @"Autohover enabled";
        locked = NO;
        
        if(wasUnlocked)
        {
            skip = true;
           [self enableAutoHover:true];
          hovering = true;
        }
    }
}

- (void) sampleFuction
{
    
}

>>>>>>> merge_branch
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)connectClick:(id)sender {
<<<<<<< HEAD
    if ([[self.bluetoothLink getState]  isEqualToString:@"idle"]) {
        [self.bluetoothLink connect:nil callback: ^ (BOOL connected) {
            if (connected) {
                NSLog(@"Connected!");
                
                // Start sending commander update
                sent = YES;
                self.commanderTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(sendCommander:) userInfo:nil repeats:YES];
            } else { // Not connected, connection error!
                NSString * title;
                NSString * body;
                
                if (self.commanderTimer) {
                    [self.commanderTimer invalidate];
                    self.commanderTimer = nil;
                }
                
                // Find the reason and prepare a message
                if ([[_bluetoothLink getError] isEqualToString:@"Bluetooth disabled"]) {
                    title = @"Bluetooth disabled";
                    body = @"Please enable Bluetooth to connect a Crazyflie";
                } else if ([[_bluetoothLink getError] isEqualToString:@"Timeout"]) {
                    title = @"Connection timeout";
                    body = @"Could not find Crazyflie";
                } else {
                    title = @"Error";
                    body = [_bluetoothLink getError];
                }
                
                // Display the message
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                            message:body
                                                               delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    } else { // Already connected or connecting, disconnecting...
        [self.bluetoothLink disconnect];
        
        [self.commanderTimer invalidate];
        self.commanderTimer = nil;
=======
    if (canBluetooth) {
        if (state == stateIdle) {
            NSArray * connectedPeritheral = [centralManager retrieveConnectedPeripheralsWithServices:@[ [CBUUID UUIDWithString:CRAZYFLIE_SERVICE] ]];
            
            if (connectedPeritheral.count > 0) {
                NSLog(@"Found Crazyflie already connected!");
                _connectingPeritheral = [connectedPeritheral firstObject];
                [centralManager connectPeripheral:_connectingPeritheral options:nil];
                [_connectProgress setProgress:0.25 animated:YES];
                state = stateConnecting;
            } else {
                NSLog(@"Start scanning");
                [centralManager scanForPeripheralsWithServices:nil options:nil];
                self.scanTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(scanningTimeout:) userInfo:nil repeats:NO];
                state = stateScanning;
            }
            
            [(UIButton *)sender setTitle:@"Cancel" forState:UIControlStateNormal];
            
        } else if (state == stateScanning) {
            NSLog(@"Scanning canceled");
            [centralManager stopScan];
            [self.scanTimer invalidate];
            self.scanTimer = nil;
            [(UIButton *)sender setTitle:@"Connect" forState:UIControlStateNormal];
            state = stateIdle;
        } else if (state == stateConnecting) {
            NSLog(@"Connection canceled");
            [centralManager cancelPeripheralConnection:_connectingPeritheral];
            [(UIButton *)sender setTitle:@"Connect" forState:UIControlStateNormal];
            state = stateIdle;
        } else if (state == stateConnected) {
            NSLog(@"Disconnecting");
            [_commanderTimer invalidate];
            [centralManager cancelPeripheralConnection:_connectingPeritheral];
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Bluetooth disabled"
                                                        message:@"Please enable Bluetooth to connect a Crazyflie"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
>>>>>>> merge_branch
    }
}

- (IBAction)settingsClick:(id)sender {
    [self performSegueWithIdentifier:@"settings" sender:nil];
}

<<<<<<< HEAD
-(void) sendCommander: (NSTimer*)timer
{
=======
- (void) scanningTimeout:(NSTimer*)timer
{
    NSLog(@"Scan timeout, stop scan");
    [centralManager stopScan];
    [self.scanTimer invalidate];
    self.scanTimer = nil;
    [[[UIAlertView alloc] initWithTitle:@"Connection timeout"
                               message:@"Could not find Crazyflie"
                              delegate:nil
                     cancelButtonTitle:@"OK"
                     otherButtonTitles:nil] show];
    state = stateIdle;
    [self.connectButton setTitle:@"Connect" forState:UIControlStateNormal];
}

- (void) centralManagerDidUpdateState:(CBCentralManager *)central
{
    if (central.state == CBCentralManagerStatePoweredOn) {
        NSLog(@"Bluetooth is available!");
        canBluetooth = YES;
    } else {
        NSLog(@"Bluetooth not available");
        canBluetooth = NO;
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSLog(@"Discodered peripheral: %@", peripheral.name);
    if ([peripheral.name  isEqual: @"Crazyflie"]) {
        [self.scanTimer invalidate];
        self.scanTimer = nil;
        [centralManager stopScan];
        NSLog(@"Stop scanning");
        self.connectingPeritheral = peripheral;
        state = stateConnecting;
        [centralManager connectPeripheral:peripheral options:nil];
        
        [self.connectProgress setProgress:0.25 animated:YES];
    }
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Preipheral connected");
    crazyflie = peripheral;
    peripheral.delegate = self;
    
    [peripheral discoverServices:@[ [CBUUID UUIDWithString:CRAZYFLIE_SERVICE] ]];
    
    [self.connectProgress setProgress:0.5 animated:YES];
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    state = stateIdle;
    [(UIButton *)_connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection failed"
                                                    message:@"Connection to Crazyflie failed"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
    for (CBService *service in peripheral.services) {
        NSLog(@"Discovered serivce %@", [service.UUID UUIDString]);
        if ([service.UUID isEqual:[CBUUID UUIDWithString:CRAZYFLIE_SERVICE]]) {
            [peripheral discoverCharacteristics:@[ [CBUUID UUIDWithString:CRTP_CHARACTERISTIC] ] forService:service];
        }
    }
    
    [self.connectProgress setProgress:0.75 animated:YES];
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
    for (CBCharacteristic *characteristic in service.characteristics) {
        NSLog(@"Discovered characteristic %@", [characteristic.UUID UUIDString]);
        if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:CRTP_CHARACTERISTIC]]) {
            self.crtpCharacteristic = characteristic;
            sent = YES;
            self.commanderTimer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(sendCommander:) userInfo:nil repeats:YES];
            [peripheral setNotifyValue:YES forCharacteristic:self.crtpCharacteristic];
        }
        
    }
    [self.connectProgress setProgress:1.0 animated:YES];
    state = stateConnected;
    [_connectButton setTitle:@"Disconnect" forState:UIControlStateNormal];
}

-(IBAction) hoverToggle:(id)sender
{
    UISwitch *ah = (UISwitch *)sender;
    if([ah isOn])
    {
        [self enableAutoHover:true];
    }
    else
    {
        [self enableAutoHover:false];
    }
}

- (void)enableAutoHover:(bool)enableHover
{
    NSData *data;
    
    //form the param packet
    struct __attribute__((packed)) {
        uint8_t header;
        uint8_t param;
        uint8_t paramValue;
    } commanderPacket;
    
    //send packet to port 2 channel 2
    commanderPacket.header = 0x22;
    
    //set the param we want to update
    commanderPacket.param = 10;
    
    if(enableHover)
    {
        NSLog(@"Autohover enabled!");
        self.isHovering = TRUE;
        commanderPacket.paramValue = 1;
    }
    else
    {
        NSLog(@"Autohover disabled!");
        self.isHovering = FALSE;
        commanderPacket.paramValue = 0;
    }
    
    //pack the data and ship it out
    data = [NSData dataWithBytes:&commanderPacket length:sizeof(commanderPacket)];
    
    [_connectingPeritheral writeValue:data forCharacteristic:_crtpCharacteristic type:CBCharacteristicWriteWithResponse];
}

-(IBAction) biasLock:(id)sender
{
    //I'm not sure why this still exists
    NSLog(@"Zeroing...");
    self.biasLocked = true;
}

-(void) sendCommander: (NSTimer*)timer
{
    //form the command packet
>>>>>>> merge_branch
    struct __attribute__((packed)) {
        uint8_t header;
        float roll;
        float pitch;
        float yaw;
        uint16_t thrust;
    } commanderPacket;
<<<<<<< HEAD
    // Mode sorted by pitch, roll, yaw, thrust versus lx, ly, rx, ry
    static const int mode2axis[4][4] = {{1, 2, 0, 3},
                                        {3, 2, 0, 1},
                                        {1, 0, 2, 3},
                                        {3, 0, 2, 1}};
    float joysticks[4];
    float jsPitch, jsRoll, jsYaw, jsThrust;
=======
    
    //set the port to 3 (no channel?)
    commanderPacket.header = 0x30;
    
    //old joystick stuff that has been replaced but was kept for reference
    
    // Mode sorted by pitch, roll, yaw, thrust versus lx, ly, rx, ry
    //
    /*static const int mode2axis[4][4] = {{1, 2, 0, 3},
                                        {1, 0, 2, 3},
                                        {1, 0, 2, 3},
                                        {3, 0, 2, 1}};*/
    
    float joysticks[4];
    float jsYaw, jsThrust;
>>>>>>> merge_branch
    
    if (locked == NO) {
        joysticks[0] = leftJoystick.x;
        joysticks[1] = leftJoystick.y;
        joysticks[2] = rightJoystick.x;
        joysticks[3] = rightJoystick.y;
    } else {
        joysticks[0] = 0;
        joysticks[1] = 0;
        joysticks[2] = 0;
        joysticks[3] = 0;
    }
<<<<<<< HEAD
    
    jsPitch  = joysticks[mode2axis[controlMode-1][0]];
    jsRoll   = joysticks[mode2axis[controlMode-1][1]];
    jsYaw    = joysticks[mode2axis[controlMode-1][2]];
    jsThrust = joysticks[mode2axis[controlMode-1][3]];
    
    if (sent) {
        NSLog(@"Send commander!");
        NSData *data;
        
        commanderPacket.header = 0x30;
        
        if (LINEAR_PR) {
            commanderPacket.pitch = jsPitch*-1*pitchRate;
            commanderPacket.roll = jsRoll*pitchRate;
        } else {
            commanderPacket.pitch = pow(jsPitch, 2) * -1 * pitchRate * ((jsPitch>0)?1:-1);
            commanderPacket.roll = pow(jsRoll, 2) * pitchRate * ((jsRoll>0)?1:-1);
        }
        
        commanderPacket.yaw = jsYaw * yawRate;
        
        int thrust;
        if (LINEAR_THRUST) {
            thrust = jsThrust*65535*(maxThrust/100);
        } else {
            thrust = sqrt(jsThrust)*65535*(maxThrust/100);
        }
        if (thrust>65535) thrust = 65535;
        if (thrust < 0) thrust = 0;
        commanderPacket.thrust = thrust;
        
        data = [NSData dataWithBytes:&commanderPacket length:sizeof(commanderPacket)];
        
        sent = NO;
        
        [_bluetoothLink sendPacket:data callback: ^(BOOL success) {
            sent = YES;
        }];
    } else {
        NSLog(@"Missed commander update!");
    }
=======
    jsYaw    = joysticks[0];
    jsThrust = joysticks[3];
    
    if (sent) {
        NSData *data;
        
        //coremotion setup stuff
        CMDeviceMotion *deviceMotion = self.motionManager.deviceMotion;
        if(deviceMotion == nil)
            return;
        
        //more coremotion setup stuff
        CMAttitude *attitude = deviceMotion.attitude;
        
        
        //the values of roll and pitched are swapped since we are using the phone in a horizontal position
        commanderPacket.pitch = ((-1*(attitude.roll*15))-self.biasPitch)+pitchBias;
        commanderPacket.roll = rollBias+((attitude.pitch*15)-self.biasRoll);
        commanderPacket.yaw = (jsYaw * yawRate)+yawBias;
        
        int thrust = 0;
        int temp;
        if(self.isHovering == FALSE)
        {
            if (LINEAR_THRUST) {
                thrust = jsThrust*65535*(maxThrust/100);
            } else {
                thrust = sqrt(jsThrust)*65535*(maxThrust/100);
            }
            if (thrust>65535) thrust = 65535;
            if (thrust < 0) thrust = 0;
            commanderPacket.thrust = thrust;
            self.lastThrottle = thrust;
        }
        
        else{
            //set a less-than-neutral thrust so that we can fall back to this after hovering
            commanderPacket.thrust = 32597;
        }
        
        //sets up the stuff needed to begin sinking after hover mode has ended
        if (sink)
        {
            sinkingThrust = 32597;
            NSLog(@"sending sink");
            commanderPacket.thrust = sinkingThrust;
            sinking = true;
            sentinal = 30;
            sink = false;
        }
        temp = thrust;
        
        //when hover ends the thrust will slowly decrease from neutral thrust until it reaches 10000 or the thrust from the user is greater
        if (sinking)
        {
            if (thrust > sinkingThrust || sinkingThrust < 10000)
            {
                sinking = FALSE;
            }
            else{
                //in theory we can just send anything less than neutral and it will reach the floor one way or the other
                //this seems to work a thousand times better
                sinkingThrust = 40000;
                commanderPacket.thrust = sinkingThrust;
            }
        }
        
        //store the throttle for reference purposes
        self.lastThrottle = thrust;
        
        //update the labels so the pilot has some sort of visual indicator
        self.labelPitch2.text = [NSString stringWithFormat:@"%f",commanderPacket.pitch];
        self.labelRoll2.text = [NSString stringWithFormat:@"%f",commanderPacket.roll];
        self.labelYaw2.text = [NSString stringWithFormat:@"%f",commanderPacket.yaw];
        
        if(self.biasLocked == TRUE)
        {
            NSLog(@"Locking Bias");
            self.biasPitch = (-1*(attitude.roll*15));
            self.biasRoll = (attitude.pitch*15);
            self.biasYaw = commanderPacket.yaw;
            
            self.labelPitch.text = [NSString stringWithFormat:@"%f",commanderPacket.pitch];
            self.labelRoll.text = [NSString stringWithFormat:@"%f",commanderPacket.roll];
            self.labelYaw.text = [NSString stringWithFormat:@"%f",commanderPacket.yaw];
            
            self.biasLocked = false;
        }
        
        if (!skip)
        {
            //if we don't need to skip this packet, ship it out
            data = [NSData dataWithBytes:&commanderPacket length:sizeof(commanderPacket)];
            
            [_connectingPeritheral writeValue:data forCharacteristic:_crtpCharacteristic type:CBCharacteristicWriteWithResponse];
        }
        else {NSLog(@"skipped");}
        
        sent = NO;
        skip = false;
        
        
    } else {
        //NSLog(@"Missed commander update!");
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
    if (error) {
        NSLog(@"Error writing characteristic value: %@",
              [error localizedDescription]);
        return;
    }
    sent  = YES;
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error changing notification state: %@",
              [error localizedDescription]);
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    if (error) {
        NSLog(@"Error disconnected from peripheral: %@",
              [error localizedDescription]);
        [[[UIAlertView alloc] initWithTitle:@"Error disconnected"
                                   message:[error localizedDescription]
                                  delegate:nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil] show];
    }
    NSLog(@"Disconnected!");
    [_connectProgress setProgress:0 animated:NO];
    [_commanderTimer invalidate];
    _commanderTimer = nil;
    _crtpCharacteristic = nil;
    _connectingPeritheral = nil;
    [_connectButton setTitle:@"Connect" forState:UIControlStateNormal];
    state = stateIdle;
>>>>>>> merge_branch
}

- (BOOL) prefersStatusBarHidden
{
    return YES;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Prepare for segue %@", segue.identifier);
    
    if ([segue.identifier  isEqual: @"settings"]) {
        settingsViewController = [segue destinationViewController];
        settingsViewController.delegate = self;
        
        settingsViewController.controlMode = controlMode;
        settingsViewController.sensitivities = [sensitivities mutableCopy];
        settingsViewController.sensitivitySetting = sensitivitySetting;
        
        [leftJoystick cancel];
        [rightJoystick cancel];
    }
}


#pragma mark - SettingsControllerDelegate
- (void) closeButtonPressed
{
    if (settingsViewController) {
        pitchRate = [settingsViewController.pitchrollSensitivity.text floatValue];
        sensitivitySetting = settingsViewController.sensitivitySetting;
        controlMode = (int)settingsViewController.controlMode;
        sensitivities = [settingsViewController.sensitivities mutableCopy];
        [self saveDefault];
    }
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
