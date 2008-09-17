xquery version "1.0";
declare namespace exist="http://exist.sourceforge.net/NS/exist"; 
declare namespace request="http://exist-db.org/xquery/request";

declare option exist:serialize "method=xhtml media-type=text/html";

return
(: check for required parameters :)
if (not($id))
    then (
    <error>
        <message>Parameter "id" is missing.  This argument is required for this web service.</message>
    </error>)
    else
      let $server-port := substring-before(request:get-url(), '/exist/rest/db/') 
      let $collection := '/db/apps/forecast-subscriptions/data'

return
<html>
   <head>
      <title>View FAQ</title>
   </head>
   <body>
   <h1>View FAQ</h1>
   {let $item := collection($collection)/subscription[id = $id]
      return
         <p>User {$item/user/text()}<br/>
             Area: {$item/area/text()}<br/>
             Status: {$item/status/text()}<br/>
             [<a href="../edit/edit.xq?id={$id}">Edit</a>
             <a href="../edit/delete.xq?id={$id}">Delete</a>] 
             </p>
   }
   <p><a href="list-items.xq">List all items</a></p>
   </body>
</html>