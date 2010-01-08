/*
 *  AudioPlayerUtil.h
 */

#import <AudioToolbox/AudioToolbox.h>

#define VERIFY_STATUS(status) AudioPlayerVerifyStatus(status, __FILE__, __LINE__)

BOOL AudioPlayerVerifyStatus(OSStatus status, char *file, int line);