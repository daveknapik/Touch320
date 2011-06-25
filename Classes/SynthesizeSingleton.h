#define SINGLETON_INTERFACE_FOR(classname) \
+ (classname*)instance;

#define SINGLETON_IMPLEMENTATION_FOR(classname) \
static classname *shared##classname = nil; \
\
+ (classname*)instance { \
if (shared##classname == nil) \
shared##classname = [[super allocWithZone:NULL] init]; \
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone*)zone { \
return [[self instance] retain]; \
} \
\
- (id)copyWithZone:(NSZone*)zone { \
return self; \
} \
\
- (id)retain { \
return self; \
} \
\
- (NSUInteger)retainCount { \
return NSUIntegerMax; \
} \
\
- (void)release { \
} \
\
- (id)autorelease { \
return self; \
}
