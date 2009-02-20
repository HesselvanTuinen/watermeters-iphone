//
//  WebService.m
//  Watermeters
//
//

#import "WebService.h"
#import "Settings.h"

static char b64[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static int encodebase64(unsigned char *dst, const unsigned char *src, int length)
{
	int   dIndex = 0;
	int   sIndex;
	
	for (sIndex = 0; sIndex < length; sIndex += 3)
    {
		int       c0 = src[sIndex];
		int       c1 = (sIndex+1 < length) ? src[sIndex+1] : 0;
		int       c2 = (sIndex+2 < length) ? src[sIndex+2] : 0;
		
		dst[dIndex++] = b64[(c0 >> 2) & 077];
		dst[dIndex++] = b64[((c0 << 4) & 060) | ((c1 >> 4) & 017)];
		dst[dIndex++] = b64[((c1 << 2) & 074) | ((c2 >> 6) & 03)];
		dst[dIndex++] = b64[c2 & 077];
    }
	
	/* If len was not a multiple of 3, then we have encoded too
	 * many characters.  Adjust appropriately.
	 */
	if (sIndex == length + 1)
	{
		/* There were only 2 bytes in that last group */
		dst[dIndex - 1] = '=';
	}
	else if (sIndex == length + 2)
	{
		/* There was only 1 byte in that last group */
		dst[dIndex - 1] = '=';
		dst[dIndex - 2] = '=';
	}
	return dIndex;
}

@interface WebService (Private)
- (void)showLogin;
@end

@implementation WebService

@synthesize url, method;

+ (NSData *)sendSyncRequest:(NSString *)aurl Method:(NSString *)aMethod {
	WebService *webService = [[WebService alloc] initWithUrl:aurl method:aMethod];
	NSData *data = [[webService doRequest] retain];
	return [data autorelease];
}

+ (NSData *)sendSyncRequest:(NSString *)aurl {
	return [WebService sendSyncRequest:aurl Method:@"GET"];
}

+ (NSData *)sendSyncPostRequest:(NSString *)aurl {
	return [WebService sendSyncRequest:aurl Method:@"POST"];
}

+ (NSData *)sendSyncPutRequest:(NSString *)aurl {
	return [WebService sendSyncRequest:aurl Method:@"PUT"];
}

+ (NSData *)sendSyncDeleteRequest:(NSString *)aurl {
	return [WebService sendSyncRequest:aurl Method:@"DELETE"];	
}

+ (NSData*) encodeBase64: (NSData*)source
{
	int           length;
	int           destlen;
	unsigned char *sBuf;
	unsigned char *dBuf;
	
	if (source == nil)
    {
		return nil;
    }
	length = [source length];
	if (length == 0)
    {
		return [NSData data];
    }
	destlen = 4 * ((length + 2) / 3);
	sBuf = (unsigned char*)[source bytes];
	dBuf = NSZoneMalloc(NSDefaultMallocZone(), destlen);
	
	destlen = encodebase64(dBuf, sBuf, length);
	
	return [NSData dataWithBytes:dBuf length:destlen];
}

+ (NSString*) encodeBase64String: (NSString*)source
{
	NSData        *d = [source dataUsingEncoding:NSASCIIStringEncoding];
	NSString      *r = nil;
	
	d = [self encodeBase64: d];
	if (d != nil)
    {
		r = [NSString allocWithZone: NSDefaultMallocZone()];
		r = [r initWithData: d encoding: NSASCIIStringEncoding];
		[r autorelease];
    }
	return r;
}

- (id)initWithUrl:(NSString *)aUrl method:(NSString *)aMethod {
	if (self = [super init]) {
		CFStringRef ct = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, aUrl, NULL, NULL, kCFStringEncodingUTF8);
		self.url = ct;
		self.method = aMethod;
	}
	return self;
}

- (NSData *)doRequest {
	NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]
														 cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:60.0];
	[request setHTTPMethod:self.method];
	[request addValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
	
	NSURLResponse *response;
	NSError *error;
	NSData *data;
	
	finished = NO;
	int auth = 0;
	do {
		data = [[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error] retain];
		if (error == nil) {
			finished = YES;
		} 
		else if (auth >= 1 && data == nil) {
			UIAlertView *nwAlert = [[UIAlertView alloc] initWithTitle:@"Retea inaccesibila" 
															  message:@"Conexiunea la Internet nu e disponibila." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[nwAlert show];
			[nwAlert release];
			finished = YES;
		} 
		else {
			[data autorelease];
			
			if (auth >= 5) {
				UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Eroare de retea" message:@"Nu se poate accesa serverul" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
				[alert show];
				[alert release];
				return @"";
			} 
			else if (auth >= 1) { 
				@throw [NSException exceptionWithName:@"Webservice Authentication" reason:@"Authenticaiton faild!" userInfo:nil];
			}
			else {
				NSString *tmp = [NSString stringWithFormat:@"%@:%@", [Settings username], [Settings password]];
				NSString *base64string = [WebService encodeBase64String:tmp];
				[request addValue:[NSString stringWithFormat:@"Basic %@", base64string] forHTTPHeaderField:@"Authorization"];
			}

			auth++;
		}
	} while (!finished);
	
	return [data autorelease];	
}

- (void)dealloc {
	[url release];
	[method release];
	[super dealloc];
}
@end
