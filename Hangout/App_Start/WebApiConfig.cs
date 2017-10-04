using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Web.Http;
using Microsoft.Owin.Security.OAuth;
using Newtonsoft.Json.Serialization;
using System.Web.Routing;

namespace Hangout
{
    public static class WebApiConfig
    {
        public static void Register(HttpConfiguration config)
        {
            RouteTable.Routes.RouteExistingFiles = true;
            // Web API routes
            config.MapHttpAttributeRoutes();

            config.Routes.MapHttpRoute(
                name: "DefaultApi",
                routeTemplate: "api/{controller}/{action}/{objectId}",
                defaults: new { objectId = RouteParameter.Optional, custId = RouteParameter.Optional, cardId = RouteParameter.Optional }
            );
            config.Routes.MapHttpRoute(
               name: "DefaultApi2",
               routeTemplate: "api/{controller}/{action}/{objectId}/user/{userid}",
               defaults: new { objectId = RouteParameter.Optional, custId = RouteParameter.Optional, cardId = RouteParameter.Optional }
           );
            config.Routes.MapHttpRoute(
              name: "DefaultApi3",
              routeTemplate: "api/{controller}/{action}/{objectId}/token/{DeviceToken}/DeviceType/{DeviceType}",
              defaults: new { objectId = RouteParameter.Optional, custId = RouteParameter.Optional, cardId = RouteParameter.Optional }
          );
            config.Routes.MapHttpRoute(
              name: "DefaultApi4",
              routeTemplate: "api/{controller}/{action}/{objectId}/token/{DeviceToken}",
              defaults: new { objectId = RouteParameter.Optional, custId = RouteParameter.Optional, cardId = RouteParameter.Optional }
          );
            config.Routes.MapHttpRoute(
             name: "DefaultApi5",
             routeTemplate: "api/{controller}/{action}/{objectId}/email/{EmailId}/DeviceId/{DeviceId}",
             defaults: new { objectId = RouteParameter.Optional, custId = RouteParameter.Optional, cardId = RouteParameter.Optional }
         );
        }
    }
}
