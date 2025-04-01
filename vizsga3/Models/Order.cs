using vizsga3.Models;

public class Order
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public string Status { get; set; }
    public DateTime OrderDate { get; set; }
    public virtual User User { get; set; }
}
