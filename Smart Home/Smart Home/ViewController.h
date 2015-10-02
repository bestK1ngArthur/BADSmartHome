//
//  ViewController.h
//  Smart Home
//
//  Created by Artem Belkov on 27/07/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "SettingsViewController.h"
#import "StatusPopoverController.h"

@interface ViewController : NSViewController <SettingsViewControllerDelegate>

@property (weak) IBOutlet NSTextField *temperatureField;
@property (weak) IBOutlet NSTextField *backgroundField;

@property (strong, nonatomic) NSStatusBar *statusBar;
@property (strong, nonatomic) NSStatusItem *statusItem;

- (IBAction)actionShowSettings:(NSButton *)sender;
- (IBAction)actionHide:(id)sender;


@end

