//
//  IriCheckingViewController.m
//  RoadApp
//
//  Created by devil2010 on 12/28/16.
//  Copyright © 2016 admin2. All rights reserved.
//

#import "IriCheckingViewController.h"
#import "Constant.h"
#import "Utilities.h"

#define TRANSFER_SERVICE_UUID           @"E20A39F4-73F5-4BC4-A12F-17D1AD07A961"
#define TRANSFER_CHARACTERISTIC_UUID    @"08590F7E-DB05-467E-8757-72F6FAEB13D4"

@interface IriCheckingViewController (){
    BEMSimpleLineGraphView *myGraph;
    UIView *bgEffectView;
    NSMutableArray *blData;
    UITextField *tfBlueToothState;
    UIActivityIndicatorView *indicator;
    int i;
}

@end

@implementation IriCheckingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:[MENU_ICI_CHECKING uppercaseString]];
    
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    _data = [[NSMutableData alloc] init];
    blData = [[NSMutableArray alloc] init];
    
    myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, self.mapView.frame.size.height, self.view.frame.size.width, 300)];
    myGraph.enableBezierCurve = NO;
    myGraph.dataSource = self;
    myGraph.delegate = self;
    myGraph.labelFont = [UIFont systemFontOfSize:13];
    myGraph.backgroundColor = [UIColor clearColor];
    myGraph.colorTop = [UIColor whiteColor];
    myGraph.colorBottom = [UIColor clearColor];
    myGraph.colorLine = [UIColor colorWithRed:124/255.0 green:181/255.0 blue:236/255.0 alpha:1];
    myGraph.colorPoint = [UIColor clearColor];
    myGraph.widthLine = 1;
    myGraph.sizePoint = 0;
    myGraph.alwaysDisplayDots = NO;
    myGraph.autoScaleYAxis = YES;
    myGraph.colorXaxisLabel = [UIColor lightGrayColor];
    myGraph.colorBackgroundXaxis = [UIColor clearColor];
    myGraph.enableYAxisLabel = YES;
    myGraph.colorYaxisLabel = [UIColor blackColor];
    myGraph.colorBackgroundYaxis = [UIColor clearColor];
    myGraph.enableReferenceYAxisLines = NO;
    myGraph.colorReferenceLines = [UIColor lightGrayColor];
    myGraph.enableLeftReferenceAxisFrameLine = NO;
    myGraph.enablePopUpReport = NO;
    myGraph.enableReferenceAxisFrame = NO;
    myGraph.animationGraphStyle = BEMLineAnimationNone;
    [self.view addSubview:myGraph];
    [myGraph setHidden:YES];
    
    [_indicator startAnimating];
    
}



- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return [NSString stringWithFormat:@"%d", (int)index];
}

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph{
    return blData.count;
}
- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[blData objectAtIndex:index] floatValue]; // The value of the point on the Y-Axis for the index.
}

-(NSInteger)numberOfYAxisLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph{
    return 8;
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [_centralManager stopScan];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
#pragma mark - slide navigation

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
    return NO;
}

#pragma mark - bluetooth

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    // You should test all scenarios
    if (central.state != CBCentralManagerStatePoweredOn) {
//        [Utilities showSimpleAlert:@"Please enable bluetooth!" atViewController:self];
        return;
    }
    
    if (central.state == CBCentralManagerStatePoweredOn) {
//        [SVProgressHUD showWithStatus:@"Finding devices" maskType:SVProgressHUDMaskTypeBlack];
        // Scan for devices
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], CBCentralManagerScanOptionAllowDuplicatesKey, nil];
        [_centralManager scanForPeripheralsWithServices:nil options:options];
        NSLog(@"Scanning started");
    }
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI {
    
    NSLog(@"Discovered %@ at %@", peripheral.name, RSSI);
    
    if (_discoveredPeripheral != peripheral) {
        // Save a local copy of the peripheral, so CoreBluetooth doesn't get rid of it
        _discoveredPeripheral = peripheral;
        
        // And connect
        if([peripheral.name isEqualToString:@"THEHEGEO"]){
            NSLog(@"Connecting to peripheral %@", peripheral);
            [_centralManager connectPeripheral:peripheral options:nil];
        }
    }
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"Failed to connect");
    [self cleanup];
}

- (void)cleanup {
    
    // See if we are subscribed to a characteristic on the peripheral
    if (_discoveredPeripheral.services != nil) {
        for (CBService *service in _discoveredPeripheral.services) {
            if (service.characteristics != nil) {
                for (CBCharacteristic *characteristic in service.characteristics) {
                    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
                        if (characteristic.isNotifying) {
                            [_discoveredPeripheral setNotifyValue:NO forCharacteristic:characteristic];
                            return;
                        }
                    }
                }
            }
        }
    }
    
    [_centralManager cancelPeripheralConnection:_discoveredPeripheral];
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"Connected  to THEHEGEO");
//    [SVProgressHUD dismiss];
    [_centralManager stopScan];
    NSLog(@"Scanning stopped: %@", peripheral.services);
    [bgEffectView removeFromSuperview];
//    [Utilities showToast:@"Conected to THEHEGEO"];
    [_data setLength:0];
    
    peripheral.delegate = self;
    if(peripheral.services) {
        NSLog(@"own service: %@", peripheral.services);
        [self peripheral:peripheral didDiscoverServices:nil];
    }else{
//        [peripheral discoverServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]]];
        [peripheral discoverServices:nil];
    }
}


- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error {
    if (error) {
        NSLog(@"didDiscoverServices error: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    
    for (CBService *service in peripheral.services) {
        NSLog(@"Fetching characteristics for service with UUID : %@", service.UUID);
        [peripheral discoverCharacteristics:nil forService:service];
    }
    // Discover other characteristics
}

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    if (error) {
        NSLog(@"didDiscoverCharacteristicsForService error: %@", [error localizedDescription]);
        [self cleanup];
        return;
    }
    
    i = 0;
    for (CBCharacteristic *characteristic in service.characteristics) {
        [peripheral setNotifyValue:YES forCharacteristic:characteristic];
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"Error");
        return;
    }
    
    if(myGraph.isHidden == YES)
        [myGraph setHidden:NO];
    @try{
        i++;
        NSString *stringFromData = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        
        NSLog(@"string from data: %@",stringFromData);

        NSArray *arr = [stringFromData componentsSeparatedByString:@","];
        float zValue = [[arr objectAtIndex:1] floatValue];
        zValue = zValue < 1500 && zValue > -1500 ? 0 : -zValue;
        if(i % 2 == 0){
            if([blData count] > 20){
                [blData removeObjectAtIndex:0];
            }
            [blData addObject:[NSNumber numberWithFloat:zValue]];
        }
        
        [myGraph reloadGraph];
        
    }@catch(NSException *e){
        NSLog(@"error : %@", e);
    }
    // Have we got everything we need?
//    if ([stringFromData isEqualToString:@"EOM"]) {
//        [_textview setText:[[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding]];
//        [peripheral setNotifyValue:NO forCharacteristic:characteristic];
    
//        [_centralManager cancelPeripheralConnection:peripheral];
//    }
    
    [_data appendData:characteristic.value];
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    
    if (![characteristic.UUID isEqual:[CBUUID UUIDWithString:TRANSFER_CHARACTERISTIC_UUID]]) {
        return;
    }
    
    if (characteristic.isNotifying) {
        NSLog(@"Notification began on %@", characteristic);
    } else {
        // Notification has stopped
        [_centralManager cancelPeripheralConnection:peripheral];
    }
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    _discoveredPeripheral = nil;
    
    [_centralManager scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:TRANSFER_SERVICE_UUID]] options:@{ CBCentralManagerScanOptionAllowDuplicatesKey : @YES }];
}


@end
