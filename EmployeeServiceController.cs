using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using WebApp.BLL.Abstract;
using WebApp.BLL.Concrete;
using WebApp.DAL;

namespace WebApp.Controllers
{
    public class EmployeeServiceController : ApiController
    {
        IEmployeeBO objEmployeeBO = null;
        IManagerBO objManagerBO = null;
        public EmployeeServiceController()
        {
            objEmployeeBO = new EmployeeBO();
            objManagerBO = new ManagerBO();
        }

        public List<vwEmployeeDetail> Get()
        {
            return objEmployeeBO.GetEmployeeDetails();
        }

        public string Put(User usr)
        {
            if (!objEmployeeBO.Update(usr))
            {
                throw new HttpResponseException(HttpStatusCode.NotFound);
            }
            else
            {
                return objManagerBO.GetManagerName(usr.ManagerID ?? 0);
            }
        }

    }
}
