//
//  Classic_c_connect.cpp
//  Classic Trek
//
//  Created by Apple Guy on 7/9/16.
//  Copyright © 2016 Pocketfiction. All rights reserved.
//

#include "Classic_c_connect.h"
#include "ObjCCall.h"

#ifdef __cplusplus
extern "C" {
#endif

    static ObjCCall *AAA_instance = NULL;
    
    void lazyAAA() {
        if (AAA_instance == NULL) {
            AAA_instance = new ObjCCall();
        }
    }
    
    void AAA_sayHi(const char *name) {
        lazyAAA();
        AAA_instance->objectiveC_Call(name);
    }
    
#ifdef __cplusplus
}
#endif