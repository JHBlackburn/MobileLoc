using System.Threading.Tasks;

namespace MobileLoc.Domain.Interfaces.Repository
{
    public interface IIlcoEntryRepository
    {
        Task MergeIlcoEntriesAsync();
    }
}