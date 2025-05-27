#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WMFMapRegionCoordinates: NSObject

@property NSNumber * _Nullable wmf_mapLattitude;
@property NSNumber * _Nullable wmf_mapLongitude;

- (BOOL)isValid;

@end

NS_ASSUME_NONNULL_END
