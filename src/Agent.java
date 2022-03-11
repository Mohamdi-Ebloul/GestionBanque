import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.swing.*;
public class Agent extends JFrame {
	Container c;
	JLabel l11,l,l6;
	static JTextField t1;
	JButton b,b1;
	JPanel p;
	
	public Agent() {
		c=this.getContentPane();
		setLayout(new FlowLayout());
		p=new JPanel();
		l= new JLabel("Ajouter un agent");
		l11= new JLabel("nom");
		b1=new JButton("Compte");
		l6= new JLabel("Manupiler un compte ");
		t1= new JTextField(50);
		
		b=new JButton("Ajouter");
		l.setVerticalAlignment(JLabel.TOP);
		p.setLayout(new GridLayout(6, 5));
		add(l);
		add(p);
		
		p.add(l11);p.add(t1);
		p.add(b);
		
		add(l6);
		add(b1);
		l.setFont(new java.awt.Font("Times New Roman", 0, 24));
		b.setFont(new java.awt.Font("Times New Roman", 0, 20)); // 
		b.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                bActionPerformed(evt);
            }
            
        });
		b1.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                b1ActionPerformed(evt);
            }
            
        });

		setSize(500,500);
		setVisible(true);
	}
	private void bActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton5ActionPerformed
		String driver="oracle.jdbc.OracleDriver";
		String jdbc_url="jdbc:oracle:thin:@//localhost:1521/XE";
		String user="System";
		String pwd="12345678";
		
        try {
        	Class.forName(driver);
    		Connection con=DriverManager.getConnection(jdbc_url,user,pwd);
    		CallableStatement st=con.prepareCall("{CALL AJOUTAGENT(?)}");
    		st.setString(1, t1.getText());
    		st.execute();
        	JOptionPane.showMessageDialog(this, "Agent ajouté avec succès");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "ereur operation");
        }


    }//GEN-LAST:event_jButton5ActionPerformed
	private void b1ActionPerformed(java.awt.event.ActionEvent evt) {
		Compte obj1=new Compte();
		obj1.setVisible(true);
		this.hide();
		
	}

	public static void inserData(String sql) throws Exception {
		
		
	}

}