#include <string.h>
#include <string>
#include "Core.h"
#include <iostream>
#include "taitank_util.h"
#include "taitank_node.h"
#include "taitank.h"

const char *CPP_BASE_STRING = "cpp says hello to %s";

const char *concatenateMyStringWithCppStringC(const char *myString) {
    char *concatenatedString = new char[strlen(CPP_BASE_STRING) + strlen(myString)];
    taitank::TaitankNode *ptr = new taitank::TaitankNode();
    taitank::SetWidth(ptr, 30);
    taitank::SetHeight(ptr, 50);
    taitank::DoLayout(ptr, NULL, NULL);
    sprintf(concatenatedString, CPP_BASE_STRING, myString);
    sprintf(concatenatedString, std::to_string(taitank::GetWidth(ptr)).c_str(), myString);
    return concatenatedString;
}
