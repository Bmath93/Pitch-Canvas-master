//
//  ExampleOscListener.h
//  PitchCanvas
//
//  Created by Student Researcher on 2/28/14.
//  Copyright (c) 2014 MAG. All rights reserved.
//

#ifndef __PitchCanvas__ExampleOscListener__
#define __PitchCanvas__ExampleOscListener__

#include <iostream>
#include <cstring>

#if defined(__BORLANDC__) // workaround for BCB4 release build intrinsics bug
namespace std {
    using ::__strcmp__;  // avoid error: E2316 '__strcmp__' is not a member of 'std'.
}
#endif

#include "osc/OscReceivedElements.h"
#include "osc/OscPacketListener.h"
#include "ip/UdpSocket.h"


#define PORT 7000

class ExampleOscListener : public osc::OscPacketListener {
protected:
    bool a1;
    osc::int32 a2;
    float a3;
    const char *a4;
    virtual void ProcessMessage( const osc::ReceivedMessage& m,
                                const IpEndpointName& remoteEndpoint )
    {
        (void) remoteEndpoint; // suppress unused parameter warning
        
        try{
            // example of parsing single messages. osc::OsckPacketListener
            // handles the bundle traversal.
            
            if( std::strcmp( m.AddressPattern(), "/test1" ) == 0 ){
                // example #1 -- argument stream interface
                osc::ReceivedMessageArgumentStream args = m.ArgumentStream();
                args >> a1 >> a2 >> a3 >> a4 >> osc::EndMessage;
                
            }
            else if( std::strcmp( m.AddressPattern(), "/test2" ) == 0 ){
                
            }
        }catch( osc::Exception& e ){
            // any parsing errors such as unexpected argument types, or
            // missing arguments get thrown as exceptions.
            std::cout << "error while parsing message: "
            << m.AddressPattern() << ": " << e.what() << "\n";
        }
    }
    
public:
    virtual float ProcessGesture( const osc::ReceivedMessage& m,
                                 const IpEndpointName& remoteEndpoint )
    {
        (void) remoteEndpoint; // suppress unused parameter warning
        
        try{
            // example of parsing single messages. osc::OsckPacketListener
            // handles the bundle traversal.
            
            if( std::strcmp( m.AddressPattern(), "/test1" ) == 0 ){
                // example #1 -- argument stream interface
                osc::ReceivedMessageArgumentStream args = m.ArgumentStream();
                args >> a1 >> a2 >> a3 >> a4 >> osc::EndMessage;
                return {a3};
            }
            else if( std::strcmp( m.AddressPattern(), "/test2" ) == 0 ){
                
            }
        }catch( osc::Exception& e ){
            // any parsing errors such as unexpected argument types, or
            // missing arguments get thrown as exceptions.
            std::cout << "error while parsing message: "
            << m.AddressPattern() << ": " << e.what() << "\n";
            return {0.0};
        }
    }
    
};

#endif /* defined(__PitchCanvas__ExampleOscListener__) */
