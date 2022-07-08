using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata;
using GrpcService.Models.SQLite;

namespace GrpcService.Database
{
    public partial class SQLiteContext : DbContext
    {
        public SQLiteContext()
        {
        }

        public SQLiteContext(DbContextOptions<SQLiteContext> options)
            : base(options)
        {
        }

        public virtual DbSet<AirPumpSetting> AirPumpSettings { get; set; } = null!;
        public virtual DbSet<MachineInfo> MachineInfos { get; set; } = null!;
        public virtual DbSet<MachineSetting> MachineSettings { get; set; } = null!;
        public virtual DbSet<OperationLog> OperationLogs { get; set; } = null!;
        public virtual DbSet<Pattern> Patterns { get; set; } = null!;
        public virtual DbSet<PatternItem> PatternItems { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlite("name=SQLiteConnection");
            }
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<MachineInfo>(entity =>
            {
                entity.HasKey(e => e.SerialNumber);

                entity.Property(e => e.SerialNumber).ValueGeneratedNever();
            });

            modelBuilder.Entity<MachineSetting>(entity =>
            {
                entity.HasKey(e => e.SettingId);

                entity.Property(e => e.SettingId).HasColumnName("Setting_ID");

                entity.Property(e => e.AlarmAfb).HasColumnName("AlarmAFB");
            });

            modelBuilder.Entity<OperationLog>(entity =>
            {
                entity.Property(e => e.Id).HasColumnName("ID");

                entity.Property(e => e.ActualTempAfb).HasColumnName("ActualTempAFB");

                entity.Property(e => e.LogId).HasColumnName("LogID");

                entity.Property(e => e.PatternId).HasColumnName("PatternID");
            });

            modelBuilder.Entity<Pattern>(entity =>
            {
                entity.HasKey(e => e.PatternNumber);

                entity.Property(e => e.UseAfb)
                    .HasColumnName("UseAFB")
                    .HasDefaultValueSql("1");

                entity.HasOne(d => d.Airpump)
                    .WithMany(p => p.Patterns)
                    .HasForeignKey(d => d.AirpumpId)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            modelBuilder.Entity<PatternItem>(entity =>
            {
                entity.HasOne(d => d.PatternNumberNavigation)
                    .WithMany(p => p.PatternItems)
                    .HasForeignKey(d => d.PatternNumber)
                    .OnDelete(DeleteBehavior.Restrict);
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
