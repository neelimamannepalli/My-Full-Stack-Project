using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApp.BLL.Abstract;
using WebApp.BLL.Concrete;
using WebApp.Models;

namespace WebApp.Controllers
{
    public class ManagerServiceController : ApiController
    {
        IManagerBO objManagerBO = null;
        public ManagerServiceController()
        {
            objManagerBO = new ManagerBO();
        }

        public List<Manager> Get()
        {
            return objManagerBO.GetManagers();
        }

    }
}
