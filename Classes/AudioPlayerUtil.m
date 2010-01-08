/*
 *  AudioPlayerUtil.c
 */

#import <Foundation/Foundation.h>
#import "AudioPlayerUtil.h"

BOOL AudioPlayerVerifyStatus(OSStatus status, char *file, int line) {
	if (status == noErr) {
		// Logging of all sucesses is quite prolific, but useful when debugging...
		// We'll turn it off by default, but if you encounter a problem, you can
		// uncomment this to trace the path of execution.
		//NSLog(@"success at %s:%i", file, line);
	} else {
		char *s = (char *)&status;
		NSLog(@"error number: %i error code: %c%c%c%c at %s:%i", status, s[3], s[2], s[1], s[0], file, line);
	}
	return status == noErr;
}