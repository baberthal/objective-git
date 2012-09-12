//
//  GTRemote.m
//  ObjectiveGitFramework
//
//  Created by Josh Abernathy on 9/12/12.
//  Copyright (c) 2012 GitHub, Inc. All rights reserved.
//

#import "GTRemote.h"

@implementation GTRemote

- (BOOL)isEqual:(id)object {
	if (object == self) return YES;
	if (![object isKindOfClass:[self class]]) return NO;

	GTRemote *otherRemote = (GTRemote *) object;
	return [otherRemote.name isEqual:self.name] && [otherRemote.URLString isEqual:self.URLString];
}

- (NSUInteger)hash {
	return self.name.hash ^ self.URLString.hash;
}

#pragma mark API

- (id)initWithGitRemote:(git_remote *)remote {
	self = [super init];
	if (self == nil) return nil;

	_git_remote = remote;

	return self;
}

- (NSString *)name {
	const char *name = git_remote_name(self.git_remote);
	if (name == NULL) return nil;

	return [[NSString alloc] initWithUTF8String:name];
}

- (NSString *)URLString {
	const char *URLString = git_remote_url(self.git_remote);
	if (URLString == NULL) return nil;

	return [[NSString alloc] initWithUTF8String:URLString];
}

@end
