import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

import javax.swing.*;
public class Compte extends JFrame {
	Container c;
	JLabel l11,l,l6,l9;
	static JTextField t1;
	JButton b,b1,b2;
	JPanel p;
	
	public Compte() {
		c=this.getContentPane();
		setLayout(new FlowLayout());
		p=new JPanel();
		l= new JLabel("Manupiler un compte");
		l9= new JLabel("Aller d'ici pour deposer l'argent");
		l11= new JLabel("Entrer le numéro de compte");
		b1=new JButton("Désactiver");
		l6= new JLabel("Manupiler un compte ");
		t1= new JTextField(50);
		
		b=new JButton("Activer");
		b2=new JButton("Déposer ou Retirer");
		l.setVerticalAlignment(JLabel.TOP);
		p.setLayout(new GridLayout(6, 5));
		add(l);
		add(p);
		
		p.add(l11);p.add(t1);
		p.add(b);
		
		
		p.add(b1);
		add(l9);
		add(b2);
		l.setFont(new java.awt.Font("Times New Roman", 0, 24));
		 
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
		b2.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                b2ActionPerformed(evt);
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
    		CallableStatement st=con.prepareCall("{CALL ACTIVERCOMPT(?)}");
    		st.setString(1, t1.getText());
    		st.execute();
        	JOptionPane.showMessageDialog(this, "Compte est activé");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "ereur operation");
        }


    }//GEN-LAST:event_jButton5ActionPerformed
	private void b1ActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_jButton5ActionPerformed
		String driver="oracle.jdbc.OracleDriver";
		String jdbc_url="jdbc:oracle:thin:@//localhost:1521/XE";
		String user="System";
		String pwd="12345678";
		
        try {
        	Class.forName(driver);
    		Connection con=DriverManager.getConnection(jdbc_url,user,pwd);
    		CallableStatement st=con.prepareCall("{CALL DESACTIVERCOMPT(?)}");
    		st.setString(1, t1.getText());
    		st.execute();
        	JOptionPane.showMessageDialog(this, "Compte est désactivé");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "ereur operation");
        }


    }//GEN-LAST:event_jButton5ActionPerformed
	private void b2ActionPerformed(java.awt.event.ActionEvent evt) {
		Depose obj1=new Depose();
		obj1.setVisible(true);
		this.hide();
		
	}

	public static void inserData(String sql) throws Exception {
		
		
	}

}