using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace GrpcService.Migrations.SqliteMigrations
{
    public partial class InitialCreate : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AirPumpSettings",
                columns: table => new
                {
                    Id = table.Column<long>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    StartTemp = table.Column<long>(type: "INTEGER", nullable: false),
                    EndTemp = table.Column<long>(type: "INTEGER", nullable: false),
                    DelayDuration = table.Column<long>(type: "INTEGER", nullable: false),
                    UseAirpump = table.Column<long>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_AirPumpSettings", x => x.Id);
                });

            migrationBuilder.CreateTable(
                name: "MachineInfos",
                columns: table => new
                {
                    SerialNumber = table.Column<long>(type: "INTEGER", nullable: false),
                    MachineModel = table.Column<long>(type: "INTEGER", nullable: false),
                    MachineName = table.Column<string>(type: "TEXT", nullable: true),
                    WarrantyStart = table.Column<long>(type: "INTEGER", nullable: false),
                    WarrantyEnd = table.Column<long>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MachineInfos", x => x.SerialNumber);
                });

            migrationBuilder.CreateTable(
                name: "MachineSettings",
                columns: table => new
                {
                    Setting_ID = table.Column<long>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    AfbStartTemp = table.Column<long>(type: "INTEGER", nullable: false),
                    AfbEndTemp = table.Column<long>(type: "INTEGER", nullable: false),
                    AfbDelay = table.Column<long>(type: "INTEGER", nullable: false),
                    PumpStartTemp = table.Column<long>(type: "INTEGER", nullable: false),
                    PumpEndTemp = table.Column<long>(type: "INTEGER", nullable: false),
                    PumpDelay = table.Column<long>(type: "INTEGER", nullable: false),
                    TubeStartTemp = table.Column<long>(type: "INTEGER", nullable: false),
                    FloorStartTemp = table.Column<long>(type: "INTEGER", nullable: false),
                    AlarmOven = table.Column<long>(type: "INTEGER", nullable: false),
                    AlarmAFB = table.Column<long>(type: "INTEGER", nullable: false),
                    ModifyDate = table.Column<long>(type: "INTEGER", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_MachineSettings", x => x.Setting_ID);
                });

            migrationBuilder.CreateTable(
                name: "OperationLogs",
                columns: table => new
                {
                    ID = table.Column<long>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    LogID = table.Column<long>(type: "INTEGER", nullable: false),
                    Door = table.Column<long>(type: "INTEGER", nullable: true),
                    PatternID = table.Column<long>(type: "INTEGER", nullable: true),
                    CurrentStep = table.Column<long>(type: "INTEGER", nullable: true),
                    TotalStep = table.Column<long>(type: "INTEGER", nullable: true),
                    PatternStatus = table.Column<string>(type: "TEXT", nullable: true),
                    ActualTempOven = table.Column<long>(type: "INTEGER", nullable: true),
                    ActualTempAFB = table.Column<long>(type: "INTEGER", nullable: true),
                    ActualTempFloor = table.Column<long>(type: "INTEGER", nullable: true),
                    ActualTempTube = table.Column<long>(type: "INTEGER", nullable: true),
                    OperationTime = table.Column<string>(type: "TEXT", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_OperationLogs", x => x.ID);
                });

            migrationBuilder.CreateTable(
                name: "Patterns",
                columns: table => new
                {
                    PatternNumber = table.Column<long>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    PatternName = table.Column<string>(type: "TEXT", nullable: true),
                    CreateDate = table.Column<string>(type: "TEXT", nullable: true),
                    ModifyDate = table.Column<string>(type: "TEXT", nullable: true),
                    AirpumpId = table.Column<long>(type: "INTEGER", nullable: true),
                    UseAFB = table.Column<long>(type: "INTEGER", nullable: true, defaultValueSql: "1")
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Patterns", x => x.PatternNumber);
                    table.ForeignKey(
                        name: "FK_Patterns_AirPumpSettings_AirpumpId",
                        column: x => x.AirpumpId,
                        principalTable: "AirPumpSettings",
                        principalColumn: "Id",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateTable(
                name: "PatternItems",
                columns: table => new
                {
                    Id = table.Column<long>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    Step = table.Column<long>(type: "INTEGER", nullable: false),
                    Temp = table.Column<long>(type: "INTEGER", nullable: false),
                    StepDuration = table.Column<long>(type: "INTEGER", nullable: false),
                    PatternNumber = table.Column<long>(type: "INTEGER", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_PatternItems", x => x.Id);
                    table.ForeignKey(
                        name: "FK_PatternItems_Patterns_PatternNumber",
                        column: x => x.PatternNumber,
                        principalTable: "Patterns",
                        principalColumn: "PatternNumber",
                        onDelete: ReferentialAction.Restrict);
                });

            migrationBuilder.CreateIndex(
                name: "IX_PatternItems_PatternNumber",
                table: "PatternItems",
                column: "PatternNumber");

            migrationBuilder.CreateIndex(
                name: "IX_Patterns_AirpumpId",
                table: "Patterns",
                column: "AirpumpId");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "MachineInfos");

            migrationBuilder.DropTable(
                name: "MachineSettings");

            migrationBuilder.DropTable(
                name: "OperationLogs");

            migrationBuilder.DropTable(
                name: "PatternItems");

            migrationBuilder.DropTable(
                name: "Patterns");

            migrationBuilder.DropTable(
                name: "AirPumpSettings");
        }
    }
}
