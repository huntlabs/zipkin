module zipkin.v2api.upload;
import zipkin.span;
import zipkin.v2api.httpclient;
import hunt.logging;

bool upload(string host , Span[] spans...)
{
    if(spans.length == 0)
        return false;

    string str = "[";
    foreach(i , s ; spans)
    {
        str ~= s.toString();
        if(i != spans.length - 1 )
            str ~= ",";
    }
    str ~= "]";

    string result;
    bool ret = post(host , str , result , CONTENT_JSON);
    if( ! ret)
        return false;

    if(result.length > 0)
    {
        logError( "post " , host , " " , str , " " , result);
        return false;
    }

    return true;
    
}