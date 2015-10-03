//
//  BADArduino.h
//  BADSmartHome
//
//  Created by Artem Belkov on 03/10/15.
//  Copyright © 2015 Artem Belkov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Cocoa/Cocoa.h>

// import IOKit headers
#include <IOKit/IOKitLib.h>
#include <IOKit/serial/IOSerialKeys.h>
#include <IOKit/IOBSD.h>
#include <IOKit/serial/ioss.h>
#include <sys/ioctl.h>

@protocol BADArduinoDelegate <NSObject>

@required
- (void)getInputString:(NSString *)inputString;

@end

@interface BADArduino : NSObject {
    IBOutlet NSPopUpButton *serialListPullDown;
    IBOutlet NSTextView *serialOutputArea;
    IBOutlet NSTextField *serialInputField;
    IBOutlet NSTextField *baudInputField;
    int serialFileDescriptor; // file handle to the serial port
    struct termios gOriginalTTYAttrs; // Hold the original termios attributes so we can reset them on quit ( best practice )
    bool readThreadRunning;
    NSTextStorage *storage;
}

@property (strong, nonatomic) NSViewController <BADArduinoDelegate> *delegate;

@property (weak) IBOutlet NSTextField *backgroundField;

- (NSString *) openSerialPort: (NSString *)serialPortFile baud: (speed_t)baudRate;
- (void)appendToIncomingText: (id) text;
- (void)incomingTextUpdateThread: (NSThread *) parentThread;
- (void) refreshSerialList: (NSString *) selectedText;
- (void) writeString: (NSString *) str;
- (void) writeByte: (uint8_t *) val;
- (IBAction) serialPortSelected: (id) cntrl;
- (IBAction) baudAction: (id) cntrl;
- (IBAction) refreshAction: (id) cntrl;
- (IBAction) sendText: (id) cntrl;
//- (IBAction) sliderChange: (NSSlider *) sldr;
//- (IBAction) hitAButton: (NSButton *) btn;
//- (IBAction) hitBButton: (NSButton *) btn;
//- (IBAction) hitCButton: (NSButton *) btn;
- (IBAction) resetButton: (NSButton *) btn;





@end
