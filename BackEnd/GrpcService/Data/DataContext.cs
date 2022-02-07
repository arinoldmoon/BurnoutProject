using GrpcService.Models;
using Microsoft.EntityFrameworkCore;

namespace GrpcService.Data
{
    public class DataContext : DbContext
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }

        public DbSet<MachineInfo> MachineInfos { get; set; }
        public DbSet<MachineSetting> MachineSettings { get; set; }
        public DbSet<AirPumpSetting> AirPumpSettings { get; set; }
        public DbSet<Pattern> Patterns { get; set; }
        public DbSet<PatternItem> PatternItems { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<MachineInfo>().HasKey(t => t.SerialNumber);
            modelBuilder.Entity<MachineSetting>().HasKey(t => t.Setting_ID);
            modelBuilder.Entity<AirPumpSetting>().HasKey(t => t.Id);
            modelBuilder.Entity<PatternItem>().HasKey(t => t.Id);
            modelBuilder.Entity<Pattern>().HasKey(t => t.PatternNumber);

            modelBuilder.Entity<AirPumpSetting>().Property(t => t.Id).ValueGeneratedOnAdd();
            modelBuilder.Entity<PatternItem>().Property(t => t.Id).ValueGeneratedOnAdd();
            modelBuilder.Entity<Pattern>().Property(t => t.PatternNumber).ValueGeneratedOnAdd();
        }
    }
}