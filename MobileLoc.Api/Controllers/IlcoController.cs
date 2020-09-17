using Microsoft.AspNetCore.Mvc;
using MobileLoc.Domain.Models.RequestDtos;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace MobileLoc.Api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class IlcoController : ControllerBase
    {
        public async Task<ActionResult> MergeIlcoEntriesAsync(IEnumerable<CreateIlcoEntryRequest> request)
        {
            return Ok();
        }
    }
}