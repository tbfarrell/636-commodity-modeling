function basic_display()

%basic display

data_time = [0, 14, 19, 26, 28, 31, 33];
data_W_abundance = [86.83, 68.97, 69.86, 32.70, 18.40, 40.25, 33.02];
data_M_abundance = [13.17, 31.03, 30.14, 67.30, 81.60, 59.75, 66.98];

hold on
plot(data_time, data_W_abundance, 'ro', 'MarkerSize', 8, 'DisplayName', 'Data W')
plot(data_time, data_M_abundance, 'bo', 'MarkerSize', 8, 'DisplayName', 'Data M');
plot(data_time, data_W_abundance, 'r-', 'LineWidth', 2, 'DisplayName', 'Model W');
plot(data_time, data_M_abundance, 'b-', 'LineWidth', 2, 'DisplayName', 'Model M');
xlabel('Time (days)');
ylabel('Abundance (%)');
title('Bacterial Abundance Over Time From Data');
legend('show');

hold off

end