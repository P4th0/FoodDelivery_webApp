using System;
using System.Linq;
using System.Threading.Tasks;
using FoodDelivery.Models;
using Microsoft.EntityFrameworkCore;

public class SessionCleanupService
{
    private readonly FoodDeliveryContext _context;

    public SessionCleanupService(FoodDeliveryContext context)
    {
        _context = context;
    }

    public async Task CleanupExpiredSessions()
    {
        var expiredSessions = await _context.UserSessions
            .Where(s => s.ExpiresAt < DateTime.UtcNow)
            .ToListAsync();

        _context.UserSessions.RemoveRange(expiredSessions);
        await _context.SaveChangesAsync();
    }
}
