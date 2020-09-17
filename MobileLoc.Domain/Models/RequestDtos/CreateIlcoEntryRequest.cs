namespace MobileLoc.Domain.Models.RequestDtos
{
    public class CreateIlcoEntryRequest
    {
        public string MakeName { get; set; }
        public string ModelName { get; set; }
        public string EntryTitle { get; set; }
        public string KeyBlankDetails { get; set; }
        public string AdditionalNotes { get; set; }
        public string CodeSeries { get; set; }
    }
}