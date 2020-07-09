using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Caching.Distributed;
using Newtonsoft.Json;
using rest_api.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace rest_api.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ItemsController : ControllerBase
    {
        private readonly IDistributedCache _distributedCache;

        public ItemsController(IDistributedCache distributedCache)
        {
            _distributedCache = distributedCache;
        }

        // GET: api/<ItemsController>
        [HttpGet]
        public async Task<IEnumerable<Item>> GetAsync()
        {
            return await GetItemsAsync();
        }

        // GET api/<ItemsController>/5
        [HttpGet("{id}")]
        public async Task<Item> GetAsync(int id)
        {
            var items = await GetItemsAsync();
            return items.FirstOrDefault(i => i.Id == id);
        }

        // POST api/<ItemsController>
        [HttpPost]
        public async Task PostAsync([FromBody] Item value)
        {
            var items = await GetItemsAsync();
            var clonedList = items.ToList();
            value.Id = (clonedList.Count > 0 ? clonedList.Max(i => i.Id) : 0) + 1;
            clonedList.Add(value);
            await UpdateItemsAsync(clonedList);
        }

        // PUT api/<ItemsController>/5
        [HttpPut("{id}")]
        public async Task PutAsync(int id, [FromBody] Item value)
        {
            var items = await GetItemsAsync();
            var clonedList = items.ToList();

            clonedList.ForEach(i =>
            {
                if (i.Id == value.Id)
                {
                    i.Body = value.Body;
                    i.Completed = value.Completed;
                }
            });
            await UpdateItemsAsync(clonedList);
        }

        // DELETE api/<ItemsController>/5
        [HttpDelete("{id}")]
        public async Task DeleteAsync(int id)
        {
            var items = await GetItemsAsync();
            var clonedList = items.ToList().Where(i => i.Id != id);

            await UpdateItemsAsync(clonedList);
        }

        [HttpGet("clear")]
        public async Task ClearAsync()
        {
            await _distributedCache.RemoveAsync("items_store");
        }

        private async Task<IEnumerable<Item>> GetItemsAsync()
        {
            var dataFromCache = await _distributedCache.GetStringAsync("items_store");

            if (string.IsNullOrEmpty(dataFromCache))
                return GetIntialData();

            return JsonConvert.DeserializeObject<IEnumerable<Item>>(dataFromCache);
        }

        private async Task UpdateItemsAsync(IEnumerable<Item> items)
        {
            var value = JsonConvert.SerializeObject(items);
            await _distributedCache.SetStringAsync("items_store", value);
        }

        private IEnumerable<Item> GetIntialData() =>
            new List<Item>();

    }
}
