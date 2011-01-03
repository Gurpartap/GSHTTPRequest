
GSHTTPRequest
===============

Provides a class to handle complex (although not much) NSURLConnection delegate routing and provides two, quick to implement, delegate methods with success or failure report, along with concerned connection data (response status code, response data, NSURLRequest instance)

Also check out https://github.com/Gurpartap/GSFormDataRequest to pair this up with!

Requirements
------------

 * An apple computer

Usage
-----

 * Kick it!
<pre>/* Prepare a NSURLRequest (or GSFormDataRequest) instance here */

// Now.
GSHTTPRequest *HTTPRequest = [[GSHTTPRequest alloc] initWithURLRequest:request delegate:self]; // Yes, it's not released here.
[HTTPRequest startURLConnection];</pre>
 * Handle delegate methods
<pre> - (void)requestSucceeded:(NSDictionary *)theResponse HTTPRequest:(id)HTTPRequest {
  // Handle success.
  [HTTPRequest release];
}</pre>

<pre> - (void)requestFailed:(NSDictionary *)response HTTPRequest:(id)HTTPRequest {
  // Handle failure.
  [HTTPRequest release];
}</pre>

The response NSDictionary argument contains three objects, "responseStatusCode", "responseString" and "request". Maybe response shouldn't parse the data into NSString (as "responseString"). Trivial change, if you need it.

Contact
-------

Find me on Twitter: http://twitter.com/Gurpartap
Or use the form at http://gurpartap.com/contact to talk privately *wink*

License
-------

Copyright (c) 2010 Gurpartap Singh, http://gurpartap.com/

This code is licensed under the MIT License

You are free:

 * to Share — to copy, distribute and transmit the work
 * to Remix — to adapt the work

Under the following conditions:

 * The copyright notice and license shall be included in all copies or substantial portions of the software.
 * Any of the above conditions can be waived if you get permission from the copyright holder.

See bundled MIT-LICENSE.txt file for detailed license terms.
