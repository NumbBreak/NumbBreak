import SwiftUI

struct NumbBreakView: View {
    @State private var isJailbroken: Bool = false
    @State private var systemStatus: String = "Idle (Ready to Patch)"
    @State private var liveWallpaperEnabled: Bool = true
    @State private var speed: Double = 0.5
    @State private var intensity: Double = 0.7
    @State private var selectedTab: Int = 0

    var body: some View {
        ZStack {
            // Głębokie czarne tło OLED
            Color.black.ignoresSafeArea()

            // Dynamiczne, subtelne tło nawiązujące do motyvu
            LinearGradient(
                colors: [Color.orange.opacity(0.12), Color.blue.opacity(0.12)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                // Nagłówek aplikacji
                HStack(spacing: 12) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(LinearGradient(colors: [.orange, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .frame(width: 40, height: 40)
                        Image(systemName: "lock.open.trianglebadge.exclamationmark")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .bold))
                    }
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("NumbBreak")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                        Text("Control Panel - v1.2")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        
                        // Status Systemu
                        HStack {
                            Text("System Status: \(systemStatus)")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.white)
                            Spacer()
                            Circle()
                                .fill(isJailbroken ? Color.green : Color.blue)
                                .frame(width: 10, height: 10)
                                .shadow(color: isJailbroken ? .green : .blue, radius: 5)
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(14)

                        // Główny Przycisk Aktywacji
                        Button(action: {
                            withAnimation(.spring()) {
                                isJailbroken.toggle()
                                systemStatus = isJailbroken ? "NumbBreak Active" : "Idle (Ready to Patch)"
                            }
                        }) {
                            Text(isJailbroken ? "NUMBBREAK ACTIVE" : "ACTIVATE NUMBBREAK")
                                .font(.system(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(
                                    LinearGradient(
                                        colors: [.orange, .blue],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    )
                                )
                                .cornerRadius(16)
                                .shadow(color: .orange.opacity(0.4), radius: 10, x: 0, y: 5)
                        }

                        // Sekcja: Visuals & Dynamics
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Visuals & Dynamics")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)

                            HStack {
                                Toggle("Live Wallpapers", isOn: $liveWallpaperEnabled)
                                    .font(.system(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .tint(.orange)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(14)

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Speed")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                Slider(value: $speed, in: 0...1)
                                    .tint(.orange)

                                Text("Intensity")
                                    .font(.system(size: 12))
                                    .foregroundColor(.gray)
                                Slider(value: $intensity, in: 0...1)
                                    .tint(.blue)
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(14)
                        }

                        // Sekcja: System Overrides
                        VStack(alignment: .leading, spacing: 12) {
                            Text("System Overrides")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.gray)

                            HStack {
                                Label("Custom Version: NumbBreak iOS 18.4.1", systemImage: "info.circle")
                                    .font(.system(size: 13))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(14)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                
                // Dolny pasek nawigacyjny (Tab Bar)
                HStack {
                    Spacer()
                    TabBarIcon(icon: "house.fill", title: "Home", isSelected: selectedTab == 0) { selectedTab = 0 }
                    Spacer()
                    TabBarIcon(icon: "paintpalette.fill", title: "Visuals", isSelected: selectedTab == 1) { selectedTab = 1 }
                    Spacer()
                    TabBarIcon(icon: "cart.fill", title: "Store", isSelected: selectedTab == 2) { selectedTab = 2 }
                    Spacer()
                    TabBarIcon(icon: "gearshape.fill", title: "Settings", isSelected: selectedTab == 3) { selectedTab = 3 }
                    Spacer()
                }
                .padding(.vertical, 10)
                .background(.ultraThinMaterial)
            }
        }
    }
}

// Pomocniczy widok ikony w dolnym pasku
struct TabBarIcon: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                Text(title)
                    .font(.system(size: 10))
            }
            .foregroundColor(isSelected ? .orange : .gray)
        }
    }
}

#Preview {
    NumbBreakView()
}