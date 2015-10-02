//
//  ViewController.m
//  Smart Home
//
//  Created by Artem Belkov on 27/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import "ViewController.h"

const static CGFloat maxTemperature = 35;

@implementation ViewController

#pragma mark - View

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statusBar = [NSStatusBar systemStatusBar];
    self.statusItem = [self.statusBar statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setTitle:@"Fuck Society"];
    [self.statusItem setAction:@selector(openStatusPopover:)];
    
    
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (NSColor *)getBackgroundColorForTemperature:(CGFloat)temperature {
    
    CGFloat red = (temperature * 255.f) / maxTemperature;
    CGFloat blue = 255.f - red;
    CGFloat green = 100.f;
    
    NSColor *color = [NSColor colorWithRed:   red /255.f
                                     green: green /255.f
                                      blue:  blue /255.f
                                     alpha: 1.f];
    
    return color;
}

#pragma mark - SettingsViewControllerDelegate

- (void)getInputString:(NSString *)inputString {
    
    NSArray *temperatureStrings = [inputString componentsSeparatedByString:@"|"];
    
    CGFloat outdoorTemperature = [[temperatureStrings firstObject] floatValue];
    CGFloat indoorTemperature = [[temperatureStrings lastObject] floatValue];

    [self.temperatureField setStringValue:[NSString stringWithFormat:@"%1.2f°С", outdoorTemperature]];
    
    [self.statusItem setTitle:[NSString stringWithFormat:@"outside: %1.2f°С room: %1.2f°С", outdoorTemperature, indoorTemperature]];
    NSLog(@"%1.2f°С", outdoorTemperature);
    
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        
        context.duration = 2;
        
        self.backgroundField.animator.backgroundColor = [self getBackgroundColorForTemperature:outdoorTemperature];
        
    } completionHandler:nil];
    
    
}

#pragma mark - Actions

- (IBAction)actionShowSettings:(NSButton *)sender {

    SettingsViewController *settingsController = [self.storyboard instantiateControllerWithIdentifier:@"SettingsViewController"];
    
    settingsController.delegate = self;
    
    [self presentViewControllerAsModalWindow:settingsController];
    
}

- (IBAction)actionHide:(id)sender {
    
    //[self dismissViewController:self];
    
}

- (void)openStatusPopover:(NSStatusItem *)sender {
    
    // Initialize controller

    StatusPopoverController *statusPopoverController = [self.storyboard instantiateControllerWithIdentifier:@"StatusPopoverController"];
    
    // Create popover
    NSPopover *statusPopover = [[NSPopover alloc] init];
    [statusPopover setContentSize:NSMakeSize(200.0, 200.0)];
    [statusPopover setBehavior:NSPopoverBehaviorTransient];
    [statusPopover setAnimates:YES];
    [statusPopover setContentViewController:statusPopoverController];
    
    // Convert point to main window coordinates
    NSRect entryRect = NSMakeRect(0, 0, 30, 30);
                        
    
    // Show popover
    [statusPopover showRelativeToRect:entryRect
                              ofView:[[NSApp mainWindow] contentView]
                       preferredEdge:NSMinYEdge];
    
    [statusPopover showRelativeToRect:NSMakeRect(0, 0, 50, 50) ofView:sender.view preferredEdge:NSMinYEdge];
    
    
}

@end