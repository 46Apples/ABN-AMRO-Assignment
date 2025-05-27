#import "WMFMapRegionCoordinates.h"

@implementation WMFMapRegionCoordinates
@synthesize wmf_mapLattitude;
@synthesize wmf_mapLongitude;

- (instancetype)init {
    self = [super init];
    
    return self;
}

- (BOOL)isValid {
    return self.wmf_mapLattitude != nil && self.wmf_mapLongitude != nil;
}

@end
